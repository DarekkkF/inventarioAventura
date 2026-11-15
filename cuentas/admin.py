from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Usuario


@admin.register(Usuario)
class UsuarioAdmin(UserAdmin):
    fieldsets = UserAdmin.fieldsets + (('Perfil del parque', {'fields': ('rol',)}),)
    add_fieldsets = UserAdmin.add_fieldsets + (('Perfil del parque', {'fields': ('rol',)}),)
    list_display = ['username', 'email', 'rol', 'is_active', 'is_staff']
    list_filter = ['rol', 'is_active']
