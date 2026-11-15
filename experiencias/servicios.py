from django.core.exceptions import ValidationError
from django.db import transaction
from django.utils import timezone
from .models import Experiencia, Reserva


@transaction.atomic
def reservar(usuario, experiencia_id):

    experiencia = Experiencia.objects.select_for_update().select_related('categoria').get(pk=experiencia_id)
    if not experiencia.activo or not experiencia.categoria.activo or experiencia.fecha_hora <= timezone.now():
        raise ValidationError('Esta experiencia ya no está disponible.')
    if Reserva.objects.filter(usuario=usuario, experiencia=experiencia).exists():
        raise ValidationError('Ya tienes una reserva para esta experiencia.')
    if experiencia.reservas.count() >= experiencia.cupo_maximo:
        raise ValidationError('No quedan cupos disponibles.')
    return Reserva.objects.create(usuario=usuario, experiencia=experiencia)
