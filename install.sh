#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

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
sudo pacman -S --noconfirm git base-devel kitty rofi waybar fastfetch swww
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
print_info "Copiando configuraciones desde $CONFIG_DIR/config...
