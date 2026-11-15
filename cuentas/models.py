from django.db import models


from django.contrib.auth.models import AbstractUser


class Usuario(AbstractUser):

    ROLES = [
        ('admin', 'Administrador'),
        ('guia', 'Guía'),
        ('turista', 'Turista'),
    ]

    rol = models.CharField(
        max_length=10,
        choices=ROLES,
        default='turista'
    )

    def __str__(self):
        return self.username
