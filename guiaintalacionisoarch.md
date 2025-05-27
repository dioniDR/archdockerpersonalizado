# GUÍA COMPLETA: Crear ISO personalizada de Arch con asistente IA (y) en modo offline

## 1️⃣ Instalar dependencias en Ubuntu (solo una vez)
```bash
sudo apt update
sudo apt install docker.io jq curl git
```

## 2️⃣ Crear estructura de trabajo
```bash
mkdir -p ~/Escritorio/archpersonalizado/{custom/airootfs/root/ai,cache_pkg,repo_local}
cd ~/Escritorio/archpersonalizado
```

## 3️⃣ Agregar el asistente IA
Copia tu ejecutable (binario) `y` y sus carpetas asociadas a:
```
custom/airootfs/root/ai/
```

## 4️⃣ Lanzador global `/usr/local/bin/y`
Esto se configura automáticamente con el script `fix.sh`.

## 5️⃣ Script de reparación `fix.sh` (plan B)
Ubicado en `/root/fix.sh` dentro del live. Si tienes problemas de permisos, ejecuta:
```bash
bash /root/fix.sh
```

## 6️⃣ Descargar paquetes en caché (opcional, para modo offline)
Dentro de un contenedor Arch:
```bash
docker run -it --rm archlinux bash
# Dentro del contenedor:
mkdir /repo_local
mkdir -p /var/cache/pacman/pkg
pacman -Syw --noconfirm jq
exit
```
Luego copia el cache a `~/Escritorio/archpersonalizado/cache_pkg/`.

## 7️⃣ Crear base de datos del repositorio local
```bash
cd ~/Escritorio/archpersonalizado/repo_local
repo-add custom.db.tar.gz ../cache_pkg/*.pkg.tar.zst
```

## 8️⃣ Compilar la ISO (modo offline)
```bash
./build_offline.sh archia-v1
```
La ISO se guardará en `custom/out/archia-v1.iso`.

## 9️⃣ Probar en VirtualBox
Arranca la ISO, inicia sesión como root y ejecuta:
```bash
y
```
Si hay problemas de permisos:
```bash
bash /root/fix.sh
```

---

**Resultado:**
- Asistente IA listo para usar con el comando `y`
- ISO personalizada y replicable
- Script de recuperación de permisos
