import os


def cargar_entorno(ruta):
    if ruta.exists():
        for linea in ruta.read_text(encoding='utf-8-sig').splitlines():
            linea = linea.strip()
            if linea and not linea.startswith('#') and '=' in linea:
                clave, valor = linea.split('=', 1)
                os.environ.setdefault(clave.strip(), valor.strip())
