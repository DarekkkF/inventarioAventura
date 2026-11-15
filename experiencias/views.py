from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied, ValidationError
from django.db import transaction
from django.db.models import Count, F
from django.db.models.deletion import ProtectedError
from django.http import Http404
from django.shortcuts import get_object_or_404, redirect
from django.urls import reverse_lazy
from django.utils import timezone
from django.views import View
from django.views.generic import CreateView, DeleteView, ListView, UpdateView
from cuentas.permisos import AdministradorMixin, OperadorMixin, TuristaMixin, es_admin
from .forms import CategoriaForm, ExperienciaForm
from .models import Categoria, Experiencia, Reserva
from .servicios import reservar


class CatalogoView(ListView):
    template_name = 'experiencias/catalogo.html'
    context_object_name = 'experiencias'

    def get_queryset(self):
        return Experiencia.objects.select_related('categoria', 'creador').filter(activo=True, categoria__activo=True, fecha_hora__gt=timezone.now()).annotate(total_reservas=Count('reservas')).annotate(cupos_libres=F('cupo_maximo') - F('total_reservas')).order_by('fecha_hora')


class CategoriaListView(AdministradorMixin, ListView):
    model = Categoria
    template_name = 'experiencias/categoria_lista.html'


class CategoriaCreateView(AdministradorMixin, CreateView):
    form_class = CategoriaForm
    template_name = 'experiencias/categoria_form.html'
    success_url = reverse_lazy('experiencias:categorias')


class CategoriaUpdateView(AdministradorMixin, UpdateView):
    model = Categoria
    form_class = CategoriaForm
    template_name = 'experiencias/categoria_form.html'
    success_url = reverse_lazy('experiencias:categorias')


class CategoriaDeleteView(AdministradorMixin, DeleteView):
    model = Categoria
    template_name = 'experiencias/categoria_eliminar.html'
    success_url = reverse_lazy('experiencias:categorias')

    def form_valid(self, form):
        try:
            return super().form_valid(form)
        except ProtectedError:
            messages.error(self.request, 'La categoría tiene experiencias asociadas. Puedes desactivarla desde Editar.')
            return redirect(self.success_url)


class ExperienciasPropiasMixin(OperadorMixin):
    model = Experiencia

    def get_queryset(self):
        consulta = Experiencia.objects.select_related('categoria', 'creador').order_by('fecha_hora')
        return consulta if es_admin(self.request.user) else consulta.filter(creador=self.request.user)


class ExperienciaListView(ExperienciasPropiasMixin, ListView):
    template_name = 'experiencias/experiencia_lista.html'


class ExperienciaCreateView(OperadorMixin, CreateView):
    form_class = ExperienciaForm
    template_name = 'experiencias/experiencia_form.html'
    success_url = reverse_lazy('experiencias:lista')

    def form_valid(self, form):
        form.instance.creador = self.request.user
        return super().form_valid(form)


class ExperienciaUpdateView(ExperienciasPropiasMixin, UpdateView):
    form_class = ExperienciaForm
    template_name = 'experiencias/experiencia_form.html'
    success_url = reverse_lazy('experiencias:lista')

    def post(self, request, *args, **kwargs):

        with transaction.atomic():
            get_object_or_404(self.get_queryset().select_for_update(), pk=kwargs['pk'])
            return super().post(request, *args, **kwargs)


class ExperienciaDeleteView(AdministradorMixin, DeleteView):
    model = Experiencia
    template_name = 'experiencias/experiencia_eliminar.html'
    success_url = reverse_lazy('experiencias:lista')


class ReservarView(TuristaMixin, View):
    def post(self, request, pk):
        try:
            reservar(request.user, pk)
            messages.success(request, 'Reserva creada. Tu pago quedó pendiente de confirmación.')
        except Experiencia.DoesNotExist:
            raise Http404
        except ValidationError as error:
            messages.error(request, error.messages[0])
        return redirect('experiencias:reservas')


class ReservaListView(LoginRequiredMixin, ListView):
    template_name = 'experiencias/reserva_lista.html'

    def get_queryset(self):
        consulta = Reserva.objects.select_related('usuario', 'experiencia').order_by('-fecha_inscripcion')
        if es_admin(self.request.user):
            return consulta
        if self.request.user.rol == 'turista':
            return consulta.filter(usuario=self.request.user)
        raise PermissionDenied


class CancelarReservaView(TuristaMixin, View):
    def post(self, request, pk):
        with transaction.atomic():
            reserva = get_object_or_404(Reserva, pk=pk, usuario=request.user)
            experiencia = Experiencia.objects.select_for_update().get(pk=reserva.experiencia_id)
            if experiencia.fecha_hora <= timezone.now() or reserva.estado_pago == 'confirmado':
                messages.error(request, 'Solo puedes cancelar reservas futuras con pago pendiente. Contacta a administración para otros cambios.')
            else:
                reserva.delete()
                messages.success(request, 'Reserva cancelada.')
        return redirect('experiencias:reservas')


class ConfirmarPagoView(AdministradorMixin, View):
    def post(self, request, pk):
        reserva = get_object_or_404(Reserva, pk=pk)
        reserva.estado_pago = 'confirmado'
        reserva.save(update_fields=['estado_pago'])
        messages.success(request, 'Pago marcado como confirmado.')
        return redirect('experiencias:reservas')
