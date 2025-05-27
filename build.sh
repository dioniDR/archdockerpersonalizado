#!/bin/bash

# Leer nombre opcional para la ISO
CUSTOM_NAME="$1"

echo "🔧 Asignando permisos a gpt_arch..."
chmod +x custom/airootfs/root/test_arch/gpt_arch

echo "📝 Creando script global en /usr/local/bin/gpt_arch..."
cat << 'EOS' > custom/airootfs/usr/local/bin/gpt_arch
#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo "Uso: gpt_arch [argumentos]"
  echo "Este comando ejecuta el asistente GPT desde /root/test_arch"
  echo "Asegúrate de tener configurado:"
  echo "  - api/config.txt (clave API)"
  echo "  - modulos/arch/config.ini (configuración)"
  exit 0
fi

cd /root/test_arch || {
  echo "❌ No se pudo acceder a /root/test_arch"
  exit 1
}

if [[ ! -f api/config.txt ]]; then
  echo "❌ Faltante: api/config.txt (clave API)"
  exit 1
fi

if [[ ! -f modulos/arch/config.ini ]]; then
  echo "❌ Faltante: modulos/arch/config.ini (configuración del módulo)"
  exit 1
fi

echo "✅ Ejecutando asistente GPT desde /root/test_arch..."
./gpt_arch "$@"
EOS

chmod +x custom/airootfs/usr/local/bin/gpt_arch

echo "🚀 Compilando ISO con Docker..."
cd custom

docker run -it --rm --privileged \
  -v "$PWD":/archiso \
  archlinux bash -c "pacman -Syu --noconfirm && pacman -S --noconfirm archiso && cd /archiso && mkarchiso -v ."

cd ..

DEFAULT_ISO="custom/out/archlinux-"*.iso

if [[ -n "$CUSTOM_NAME" ]]; then
  NEW_ISO="custom/out/${CUSTOM_NAME}.iso"
  mv $DEFAULT_ISO $NEW_ISO
  echo "✅ ISO renombrada a: $NEW_ISO"
else
  echo "✅ ISO compilada con nombre por defecto: $DEFAULT_ISO"
fi
