from django import forms
from django.utils import timezone
from .models import Categoria, Experiencia


class CategoriaForm(forms.ModelForm):
    class Meta:
        model = Categoria
        fields = ['nombre', 'descripcion', 'activo']
        widgets = {'descripcion': forms.Textarea(attrs={'rows': 3})}


class ExperienciaForm(forms.ModelForm):
    class Meta:
        model = Experiencia
        fields = ['titulo', 'descripcion', 'precio', 'cupo_maximo', 'fecha_hora', 'categoria', 'activo']
        widgets = {
            'descripcion': forms.Textarea(attrs={'rows': 4}),
            'fecha_hora': forms.DateTimeInput(format='%Y-%m-%dT%H:%M', attrs={'type': 'datetime-local'}),
        }

    def clean_fecha_hora(self):
        fecha = self.cleaned_data['fecha_hora']
        if fecha <= timezone.now() and (not self.instance.pk or self.instance.fecha_hora != fecha):
            raise forms.ValidationError('Selecciona una fecha futura.')
        return fecha

    def clean_cupo_maximo(self):
        cupo = self.cleaned_data['cupo_maximo']
        if self.instance.pk and cupo < self.instance.reservas.count():
            raise forms.ValidationError('El cupo no puede ser menor que las reservas existentes.')
        return cupo
