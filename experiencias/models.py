from django.db import models


from django.conf import settings
from django.core.validators import MinValueValidator


class Categoria(models.Model):

    nombre = models.CharField(max_length=100, unique=True)
    descripcion = models.TextField()
    activo = models.BooleanField(default=True)

    def __str__(self):
        return self.nombre


class Experiencia(models.Model):

    titulo = models.CharField(max_length=150)
    descripcion = models.TextField()

    precio = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0)]
    )

    cupo_maximo = models.PositiveIntegerField(
        validators=[MinValueValidator(1)]
    )

    fecha_hora = models.DateTimeField()
    activo = models.BooleanField(default=True)

    categoria = models.ForeignKey(
        Categoria,
        on_delete=models.PROTECT,
        related_name='experiencias'
    )

    creador = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name='experiencias_creadas'
    )

    def __str__(self):
        return self.titulo


class Reserva(models.Model):

    ESTADOS_PAGO = [
        ('pendiente', 'Pendiente'),
        ('confirmado', 'Confirmado'),
    ]

    usuario = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='reservas'
    )

    experiencia = models.ForeignKey(
        Experiencia,
        on_delete=models.CASCADE,
        related_name='reservas'
    )

    fecha_inscripcion = models.DateTimeField(auto_now_add=True)

    estado_pago = models.CharField(
        max_length=10,
        choices=ESTADOS_PAGO,
        default='pendiente'
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['usuario', 'experiencia'],
                name='reserva_unica_usuario_experiencia'
            )
        ]

    def __str__(self):
        return f'{self.usuario.username} - {self.experiencia.titulo}'
