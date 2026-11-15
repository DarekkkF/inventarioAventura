from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin


def es_admin(usuario):
    return usuario.is_authenticated and (usuario.is_superuser or usuario.rol == 'admin')


class AdministradorMixin(LoginRequiredMixin, UserPassesTestMixin):
    def test_func(self):
        return es_admin(self.request.user)


class OperadorMixin(LoginRequiredMixin, UserPassesTestMixin):
    def test_func(self):
        return es_admin(self.request.user) or self.request.user.rol == 'guia'


class TuristaMixin(LoginRequiredMixin, UserPassesTestMixin):
    def test_func(self):
        return self.request.user.rol == 'turista' and not es_admin(self.request.user)
