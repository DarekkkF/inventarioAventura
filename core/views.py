from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView
from cuentas.models import Usuario
from cuentas.permisos import es_admin
from experiencias.models import Categoria, Experiencia, Reserva


class InicioView(TemplateView):
    template_name = 'core/inicio.html'


class PanelView(LoginRequiredMixin, TemplateView):
    template_name = 'core/panel.html'

    def get_context_data(self, **kwargs):
        contexto = super().get_context_data(**kwargs)
        usuario = self.request.user
        if es_admin(usuario):
            contexto['indicadores'] = [('Usuarios', Usuario.objects.count()), ('Categorías', Categoria.objects.count()), ('Experiencias', Experiencia.objects.count()), ('Reservas', Reserva.objects.count())]
        elif usuario.rol == 'guia':
            propias = Experiencia.objects.filter(creador=usuario)
            contexto['indicadores'] = [('Mis experiencias', propias.count()), ('Publicadas', propias.filter(activo=True).count())]
        else:
            propias = Reserva.objects.filter(usuario=usuario)
            contexto['indicadores'] = [('Mis reservas', propias.count()), ('Pagos confirmados', propias.filter(estado_pago='confirmado').count()), ('Pagos pendientes', propias.filter(estado_pago='pendiente').count())]
        return contexto
