from datetime import timedelta
from django.core.exceptions import ValidationError
from django.test import Client, TestCase
from django.urls import reverse
from django.utils import timezone
from cuentas.models import Usuario
from .models import Categoria, Experiencia, Reserva
from .servicios import reservar


class PermisosYReservasTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.admin = Usuario.objects.create_user(username='administrador', password='test', rol='admin')
        cls.guia = Usuario.objects.create_user(username='guia', password='test', rol='guia')
        cls.otro_guia = Usuario.objects.create_user(username='otro_guia', password='test', rol='guia')
        cls.turista = Usuario.objects.create_user(username='turista', password='test', rol='turista')
        cls.otro_turista = Usuario.objects.create_user(username='otro_turista', password='test', rol='turista')
        cls.categoria = Categoria.objects.create(nombre='Kayak', descripcion='Navegación')
        cls.experiencia = Experiencia.objects.create(titulo='Lago privado del guía', descripcion='Ruta guiada', precio=15000, cupo_maximo=1, fecha_hora=timezone.now() + timedelta(days=10), categoria=cls.categoria, creador=cls.guia)

    def test_guia_no_puede_ver_ni_modificar_experiencia_ajena(self):
        self.client.force_login(self.otro_guia)
        self.assertNotContains(self.client.get(reverse('experiencias:lista')), self.experiencia.titulo)
        url = reverse('experiencias:editar', args=[self.experiencia.pk])
        self.assertEqual(self.client.get(url).status_code, 404)
        self.assertEqual(self.client.post(url, {'titulo': 'Ataque'}).status_code, 404)

    def test_guia_no_puede_eliminar_ni_administrar(self):
        self.client.force_login(self.guia)
        for nombre in ['experiencias:categorias', 'cuentas:usuarios', 'experiencias:reservas']:
            self.assertEqual(self.client.get(reverse(nombre)).status_code, 403)
        self.assertEqual(self.client.post(reverse('experiencias:eliminar', args=[self.experiencia.pk])).status_code, 403)
        self.assertTrue(Experiencia.objects.filter(pk=self.experiencia.pk).exists())

    def test_turista_no_puede_acceder_gestion(self):
        self.client.force_login(self.turista)
        for nombre in ['experiencias:lista', 'experiencias:crear', 'experiencias:categorias', 'cuentas:usuarios']:
            self.assertEqual(self.client.get(reverse(nombre)).status_code, 403)

    def test_reserva_duplicada_y_cupo_agotado(self):
        reservar(self.turista, self.experiencia.pk)
        with self.assertRaises(ValidationError):
            reservar(self.turista, self.experiencia.pk)
        with self.assertRaises(ValidationError):
            reservar(self.otro_turista, self.experiencia.pk)
        self.assertEqual(Reserva.objects.count(), 1)

    def test_reserva_no_disponible(self):
        for campo, valor in [('activo', False), ('fecha_hora', timezone.now() - timedelta(days=1))]:
            original = getattr(self.experiencia, campo)
            setattr(self.experiencia, campo, valor)
            self.experiencia.save()
            with self.assertRaises(ValidationError):
                reservar(self.turista, self.experiencia.pk)
            setattr(self.experiencia, campo, original)
        self.experiencia.save()
        self.categoria.activo = False
        self.categoria.save()
        with self.assertRaises(ValidationError):
            reservar(self.turista, self.experiencia.pk)

    def test_historial_privado_y_cancelacion_ajena(self):
        reserva = reservar(self.otro_turista, self.experiencia.pk)
        self.client.force_login(self.turista)
        self.assertNotContains(self.client.get(reverse('experiencias:reservas')), self.experiencia.titulo)
        self.assertEqual(self.client.post(reverse('experiencias:cancelar', args=[reserva.pk])).status_code, 404)
        self.assertEqual(self.client.post(reverse('experiencias:confirmar', args=[reserva.pk])).status_code, 403)

    def test_cancelar_libera_cupo(self):
        reserva = reservar(self.turista, self.experiencia.pk)
        self.client.force_login(self.turista)
        self.client.post(reverse('experiencias:cancelar', args=[reserva.pk]))
        self.assertFalse(Reserva.objects.exists())
        reservar(self.otro_turista, self.experiencia.pk)

    def test_no_cancelar_pago_confirmado(self):
        reserva = reservar(self.turista, self.experiencia.pk)
        self.client.force_login(self.admin)
        self.client.post(reverse('experiencias:confirmar', args=[reserva.pk]))
        self.client.force_login(self.turista)
        self.client.post(reverse('experiencias:cancelar', args=[reserva.pk]))
        self.assertEqual(Reserva.objects.get(pk=reserva.pk).estado_pago, 'confirmado')

    def test_registro_no_permite_elevar_rol(self):
        respuesta = self.client.post(reverse('cuentas:registro'), {'username': 'nuevo', 'password1': 'UnaClave!2026Nueva', 'password2': 'UnaClave!2026Nueva', 'rol': 'admin', 'is_superuser': True})
        self.assertEqual(respuesta.status_code, 302)
        nuevo = Usuario.objects.get(username='nuevo')
        self.assertEqual(nuevo.rol, 'turista')
        self.assertFalse(nuevo.is_superuser)

    def test_creador_se_asigna_desde_sesion(self):
        self.client.force_login(self.guia)
        datos = {'titulo': 'Ruta nueva', 'descripcion': 'Bosque', 'precio': '1000', 'cupo_maximo': 4, 'fecha_hora': (timezone.now() + timedelta(days=3)).strftime('%Y-%m-%dT%H:%M'), 'categoria': self.categoria.pk, 'activo': True, 'creador': self.otro_guia.pk}
        self.assertEqual(self.client.post(reverse('experiencias:crear'), datos).status_code, 302)
        self.assertEqual(Experiencia.objects.get(titulo='Ruta nueva').creador, self.guia)

    def test_no_reducir_cupo_bajo_reservas(self):
        from .forms import ExperienciaForm
        reservar(self.turista, self.experiencia.pk)
        form = ExperienciaForm({'titulo': 'Ruta', 'descripcion': 'Descripción', 'precio': 500, 'cupo_maximo': 0, 'fecha_hora': self.experiencia.fecha_hora, 'categoria': self.categoria.pk}, instance=self.experiencia)
        self.assertFalse(form.is_valid())
        self.assertIn('cupo_maximo', form.errors)

    def test_paginas_publicas_y_privadas_renderizan(self):
        for nombre in ['core:inicio', 'experiencias:catalogo', 'cuentas:login', 'cuentas:registro']:
            self.assertEqual(self.client.get(reverse(nombre)).status_code, 200)
        self.client.force_login(self.admin)
        for nombre in ['core:panel', 'cuentas:usuarios', 'cuentas:usuario_crear', 'experiencias:lista', 'experiencias:crear', 'experiencias:categorias', 'experiencias:categoria_crear', 'experiencias:reservas']:
            self.assertEqual(self.client.get(reverse(nombre)).status_code, 200)

    def test_csrf_y_metodos(self):
        cliente = Client(enforce_csrf_checks=True)
        cliente.force_login(self.turista)
        url = reverse('experiencias:reservar', args=[self.experiencia.pk])
        self.assertEqual(cliente.post(url).status_code, 403)
        self.assertEqual(self.client.get(url).status_code, 302)
        self.client.force_login(self.turista)
        self.assertEqual(self.client.get(url).status_code, 405)

    def test_categoria_protegida(self):
        self.client.force_login(self.admin)
        respuesta = self.client.post(reverse('experiencias:categoria_eliminar', args=[self.categoria.pk]), follow=True)
        self.assertContains(respuesta, 'La categoría tiene experiencias asociadas')
        self.assertTrue(Categoria.objects.filter(pk=self.categoria.pk).exists())
