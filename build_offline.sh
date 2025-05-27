#!/bin/bash

# Limpia los directorios de salida y trabajo para evitar residuos de builds anteriores
rm -rf custom/out/*
rm -rf custom/work/*

# 📍 Nombre personalizado si se pasa como argumento
ISO_NAME=${1:-archlinux-offline}

echo "🧱 Compilando ISO offline con nombre: $ISO_NAME.iso"
sleep 1

# 📁 Asegura que estás en la carpeta correcta
cd "$(dirname "$0")"

# 🚀 Ejecuta el contenedor y compila
docker run -it --rm --privileged \
  -v "$PWD/custom":/archiso \
  -v "$PWD/repo_local":/repo_local \
  -v "$PWD/cache_pkg":/var/cache/pacman/pkg \
  archlinux bash -c "
    pacman -Sy --config /archiso/pacman.conf --noconfirm archiso &&
    cd /archiso &&
    mkarchiso -v .
  "

# 📝 Renombra la ISO si se generó
ISO_DEFAULT=$(ls custom/out/archlinux-*.iso 2>/dev/null)

if [[ -f \"$ISO_DEFAULT\" ]]; then
  mv \"$ISO_DEFAULT\" \"custom/out/${ISO_NAME}.iso\"
  echo \"✅ ISO generada y renombrada a: custom/out/${ISO_NAME}.iso\"
else
  echo \"❌ No se encontró ninguna ISO generada.\"
fi

