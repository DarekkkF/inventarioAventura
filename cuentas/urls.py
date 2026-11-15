from django.contrib.auth.views import LogoutView
from django.urls import path
from . import views

app_name = 'cuentas'
urlpatterns = [
    path('login/', views.IngresoView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('registro/', views.RegistroView.as_view(), name='registro'),
    path('usuarios/', views.UsuarioListView.as_view(), name='usuarios'),
    path('usuarios/crear/', views.UsuarioCreateView.as_view(), name='usuario_crear'),
    path('usuarios/<int:pk>/editar/', views.UsuarioUpdateView.as_view(), name='usuario_editar'),
    path('usuarios/<int:pk>/eliminar/', views.UsuarioDeleteView.as_view(), name='usuario_eliminar'),
]
