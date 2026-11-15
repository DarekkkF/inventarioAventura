from django.urls import path
from . import views

app_name = 'experiencias'
urlpatterns = [
    path('', views.CatalogoView.as_view(), name='catalogo'),
    path('gestion/', views.ExperienciaListView.as_view(), name='lista'),
    path('crear/', views.ExperienciaCreateView.as_view(), name='crear'),
    path('<int:pk>/editar/', views.ExperienciaUpdateView.as_view(), name='editar'),
    path('<int:pk>/eliminar/', views.ExperienciaDeleteView.as_view(), name='eliminar'),
    path('<int:pk>/reservar/', views.ReservarView.as_view(), name='reservar'),
    path('categorias/', views.CategoriaListView.as_view(), name='categorias'),
    path('categorias/crear/', views.CategoriaCreateView.as_view(), name='categoria_crear'),
    path('categorias/<int:pk>/editar/', views.CategoriaUpdateView.as_view(), name='categoria_editar'),
    path('categorias/<int:pk>/eliminar/', views.CategoriaDeleteView.as_view(), name='categoria_eliminar'),
    path('reservas/', views.ReservaListView.as_view(), name='reservas'),
    path('reservas/<int:pk>/cancelar/', views.CancelarReservaView.as_view(), name='cancelar'),
    path('reservas/<int:pk>/confirmar/', views.ConfirmarPagoView.as_view(), name='confirmar'),
]
