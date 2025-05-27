# ArchPersonalizado con Asistente IA (y)

## Descripción
ISO personalizada de Arch Linux con asistente IA offline (`y`). Todo el flujo es reproducible, portable y dockerizado. El asistente se instala en `/root/ai/y` y es accesible globalmente como `y`.

---

## Instalación y compilación rápida (Docker recomendado)

### 1️⃣ Clona el repositorio y entra al proyecto
```bash
git clone https://github.com/TU_USUARIO/archdockerpersonalizado.git
cd archdockerpersonalizado
```

### 2️⃣ Construye la imagen Docker
```bash
docker build -t archpersonalizado .
```

### 3️⃣ Prepara carpetas de trabajo (solo la primera vez)
```bash
mkdir -p custom/airootfs/root/ai cache_pkg repo_local custom/out
```

### 4️⃣ (Opcional) Agrega tu ejecutable y recursos IA
Copia tu binario `y` y sus carpetas a:
```
custom/airootfs/root/ai/
```

### 5️⃣ Compila la ISO personalizada
```bash
docker run --rm -it \
  -v "$PWD/custom":/workspace/custom \
  -v "$PWD/cache_pkg":/workspace/cache_pkg \
  -v "$PWD/repo_local":/workspace/repo_local \
  -v "$PWD/build_offline.sh":/workspace/build_offline.sh \
  -w /workspace \
  archpersonalizado bash build_offline.sh archia-v1
```
La ISO aparecerá en `custom/out/archia-v1.iso`.

### 6️⃣ Probar la ISO
Arranca la ISO en VirtualBox/QEMU, inicia sesión como root y ejecuta:
```bash
y
```
Si hay problemas de permisos:
```bash
bash /root/fix.sh
```

---

## Estructura y archivos clave
- `build_offline.sh` — Script principal de build offline
- `Dockerfile` — Entorno reproducible para compilar
- `custom/airootfs/root/ai/` — Asistente IA y recursos
- `custom/airootfs/usr/local/bin/y` — Lanzador global
- `custom/airootfs/root/fix.sh` — Reparador de permisos
- `custom/packages.x86_64` — Paquetes extra a incluir (ej: jq, openssh)
- `cache_pkg/` — Paquetes descargados (no se suben a git)
- `repo_local/` — Repositorio local (no se sube a git)
- `custom/out/` — ISO generada (no se sube a git)

---

## Notas
- El build es 100% offline si tienes los paquetes en `cache_pkg/`.
- Puedes personalizar la lista de paquetes en `custom/packages.x86_64`.
- El asistente IA funcionará desde cualquier directorio gracias al lanzador global.

---

**Autor:** Tu nombre aquí  
**Fecha:** 27 de mayo de 2025
