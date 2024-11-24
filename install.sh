#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

show_banner() {
  echo -e "${GREEN}"
  echo "   ______      __  __           _    _ _  __   ______       _ _   "
  echo "  / __ \ \    / / |  \/  |   /\ | |  | | | \ \ / / __ \     | | |  "
  echo " | |  | \ \  / /  | \  / |  /  \| |  | | |  \ V / |  | |    | | |  "
  echo " | |  | |\ \/ /   | |\/| | / /\ \ |  | | |   > <| |  | |_   | | |  "
  echo " | |__| | \  /    | |  | |/ ____ \ |__| | |  / . \ |__| | |_|_|_|  "
  echo "  \____/   \/     |_|  |_/_/    \_\____/|_| /_/ \_\____/ (_|_|_|_) "
  echo -e "             ${CYAN}Dotfiles Installer for Hyprland & Arch Linux${RESET}"
  echo
}

# Mostrar el banner al inicio
clear
show_banner

# Función para imprimir mensajes
print_info() {
  echo -e "${CYAN}[INFO]${RESET} $1"
}

print_success() {
  echo -e "${GREEN}[SUCCESS]${RESET} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARNING]${RESET} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${RESET} $1"
}

# Verificar si se proporcionó un directorio de configuración
if [ -z "$1" ]; then
  print_error "Por favor, proporciona el directorio de configuración como argumento."
  echo "Uso: ./install.sh /ruta/al/directorio/de/configuracion"
  exit 1
fi

CONFIG_DIR=$1

# Actualizar y sincronizar la base de datos de paquetes
print_info "Actualizando el sistema y sincronizando la base de datos de paquetes..."
sudo pacman -Syu --noconfirm
clear

# Instalar paquetes necesarios
print_info "Instalando paquetes esenciales..."
sudo pacman -S --noconfirm git base-devel kitty rofi waybar fastfetch swww swaync ttf-iosevkaterm-nerd
clear

# Instalar Fish y Oh My Fish (opcional)
read -p "$(echo -e "${CYAN}¿Deseas instalar fish como shell (S/n)? ${RESET}")" install_fish
install_fish=${install_fish:-S}
clear

if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  print_info "Instalando fish..."
  sudo pacman -S --noconfirm fish
  clear

  read -p "$(echo -e "${CYAN}¿Deseas instalar Oh My Fish (OMF) (S/n)? ${RESET}")" install_omf
  install_omf=${install_omf:-S}
  clear

  if [[ "$install_omf" =~ ^[Ss]$ ]]; then
    print_info "Instalando Oh My Fish (OMF)..."
    curl -L https://get.oh-my.fish | fish
    fish -c "omf install pj"
    clear
  fi
fi

# Instalar yay para gestionar paquetes de AUR
print_info "Instalando yay para gestionar paquetes de AUR..."
if ! command -v yay &> /dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi
clear

# Instalar paquetes adicionales con yay
print_info "Instalando paquetes de AUR con yay..."
yay -S --noconfirm waypaper python-screeninfo python-imageio
clear

# Copiar configuraciones desde el directorio proporcionado
print_info "Copiando configuraciones desde $CONFIG_DIR/config..."
cp -r $CONFIG_DIR/config/kitty ~/.config/
cp -r $CONFIG_DIR/config/hypr ~/.config/
cp -r $CONFIG_DIR/config/waybar ~/.config/
cp -r $CONFIG_DIR/config/fastfetch ~/.config/
cp -r $CONFIG_DIR/config/rofi ~/.config/
cp -r $CONFIG_DIR/config/waypaper ~/.config/
clear

# Copiar configuraciones de fish si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  print_info "Copiando configuraciones de fish..."
  cp -r $CONFIG_DIR/config/fish ~/.config/
  chsh -s /usr/bin/fish
  clear
fi

# Crear directorios de workspace en /home
print_info "Creando directorios de trabajo..."
mkdir -p ~/workspace/{projects,documents,scripts}
clear

# Eliminar el directorio de configuración después de copiarlo
read -p "$(echo -e "${CYAN}¿Deseas eliminar el directorio de configuraciones del repositorio? (S/n): ${RESET}")" delete_config
delete_config=${delete_config:-S}

if [[ "$delete_config" =~ ^[Ss]$ ]]; then
  print_info "Eliminando el directorio de configuraciones del repositorio..."
  rm -rf "$CONFIG_DIR/config"
  print_success "Directorio de configuraciones eliminado correctamente."
fi
clear
show_banner

# Finalizar con opción de reinicio
read -p "$(echo -e "${CYAN}¿Deseas reiniciar el sistema ahora? (S/n): ${RESET}")" restart_now
restart_now=${restart_now:-S}

if [[ "$restart_now" =~ ^[Ss]$ ]]; then
  print_warning "Reiniciando el sistema..."
  sudo reboot
else
  print_success "Instalación y configuración completadas. Por favor, reinicia el sistema manualmente más tarde."
fi
