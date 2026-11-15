from django.urls import path
from .views import InicioView, PanelView

app_name = 'core'
urlpatterns = [path('', InicioView.as_view(), name='inicio'), path('panel/', PanelView.as_view(), name='panel')]
