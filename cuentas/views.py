from django.contrib import messages
from django.contrib.auth.views import LoginView
from django.db.models.deletion import ProtectedError
from django.shortcuts import redirect
from django.urls import reverse_lazy
from django.views.generic import CreateView, DeleteView, ListView, UpdateView
from .forms import RegistroForm, UsuarioCrearForm, UsuarioEditarForm
from .models import Usuario
from .permisos import AdministradorMixin


class IngresoView(LoginView):
    template_name = 'cuentas/login.html'
    redirect_authenticated_user = True


class RegistroView(CreateView):
    form_class = RegistroForm
    template_name = 'cuentas/registro.html'
    success_url = reverse_lazy('cuentas:login')

    def form_valid(self, form):
        form.instance.rol = 'turista'
        messages.success(self.request, 'Cuenta creada. Ya puedes iniciar sesión.')
        return super().form_valid(form)


class UsuarioListView(AdministradorMixin, ListView):
    model = Usuario
    template_name = 'cuentas/usuario_lista.html'


class UsuarioCreateView(AdministradorMixin, CreateView):
    form_class = UsuarioCrearForm
    template_name = 'cuentas/usuario_form.html'
    success_url = reverse_lazy('cuentas:usuarios')


class UsuarioUpdateView(AdministradorMixin, UpdateView):
    model = Usuario
    form_class = UsuarioEditarForm
    template_name = 'cuentas/usuario_form.html'
    success_url = reverse_lazy('cuentas:usuarios')

    def get_queryset(self):
        return Usuario.objects.filter(is_superuser=False)

    def form_valid(self, form):
        if self.object.pk == self.request.user.pk and (form.cleaned_data['rol'] != 'admin' or not form.cleaned_data['is_active']):
            form.add_error(None, 'No puedes quitarte el acceso de administrador.')
            return self.form_invalid(form)
        return super().form_valid(form)


class UsuarioDeleteView(AdministradorMixin, DeleteView):
    model = Usuario
    template_name = 'cuentas/usuario_eliminar.html'
    success_url = reverse_lazy('cuentas:usuarios')

    def get_queryset(self):
        return Usuario.objects.filter(is_superuser=False).exclude(pk=self.request.user.pk)

    def form_valid(self, form):
        try:
            return super().form_valid(form)
        except ProtectedError:
            messages.error(self.request, 'Este usuario tiene experiencias. Desactívalo desde Editar para conservar sus registros.')
            return redirect(self.success_url)
