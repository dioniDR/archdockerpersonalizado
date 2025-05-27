#!/bin/bash
# Script para iniciar el proyecto desde cero, dockerizar y compilar la ISO personalizada

set -e

# 1. Clona el repositorio (si es necesario)
# git clone https://github.com/TU_USUARIO/archdockerpersonalizado.git
# cd archdockerpersonalizado

# 2. Prepara carpetas de trabajo
mkdir -p custom/airootfs/root/ai cache_pkg repo_local custom/out

# 3. Construye la imagen Docker
if ! docker image inspect archpersonalizado >/dev/null 2>&1; then
  docker build -t archpersonalizado .
fi

# 4. (Opcional) Copia tu binario y recursos IA a custom/airootfs/root/ai/
# cp /ruta/a/y custom/airootfs/root/ai/

# 5. Compila la ISO personalizada
# Puedes cambiar 'archia-v1' por el nombre que desees

docker run --rm -it \
  -v "$PWD/custom":/workspace/custom \
  -v "$PWD/cache_pkg":/workspace/cache_pkg \
  -v "$PWD/repo_local":/workspace/repo_local \
  -v "$PWD/build_offline.sh":/workspace/build_offline.sh \
  -w /workspace \
  archpersonalizado bash build_offline.sh archia-v1

echo "\n✅ Proceso finalizado. La ISO está en custom/out/archia-v1.iso"
