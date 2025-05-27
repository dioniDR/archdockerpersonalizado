# Dockerfile para build offline de ArchPersonalizado
# Usa la imagen oficial de Arch Linux
FROM archlinux:latest

# Instala dependencias necesarias para el build
RUN pacman -Syu --noconfirm archiso git jq curl

# Crea usuario de trabajo (opcional, puedes usar root)
WORKDIR /workspace

# Copia solo los archivos de personalización y scripts
COPY . /workspace

# Da permisos de ejecución a los scripts principales
RUN chmod +x /workspace/build_offline.sh \
    && chmod +x /workspace/custom/airootfs/root/fix.sh || true

# Punto de entrada por defecto: bash interactivo
CMD ["bash"]
