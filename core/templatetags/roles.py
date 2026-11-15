from django import template
from cuentas.permisos import es_admin

register = template.Library()
register.filter('es_admin', es_admin)
