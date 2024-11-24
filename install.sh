#!/bin/bash

# Script de instalación para Arch Linux
set -e  # Detener el script en caso de error

# Función para mostrar mensajes en colores
info() { echo -e "\e[34m[INFO]\e[0m $1"; }
success() { echo -e "\e[32m[SUCCESS]\e[0m $1"; }
error() { echo -e "\e[31m[ERROR]\e[0m $1"; }

# Ruta al directorio de configuración en el repositorio
CONFIG_DIR="$(pwd)/config"

# Verificar si el directorio de configuraciones existe
if [ ! -d "$CONFIG_DIR" ]; then
  error "No se encontró el directorio de configuraciones ($CONFIG_DIR). Asegúrate de haber clonado correctamente el repositorio."
  exit 1
fi

# Actualizar y sincronizar la base de datos de paquetes
info "Actualizando la base de datos de paquetes..."
sudo pacman -Syu --noconfirm

# Instalar paquetes necesarios
info "Instalando paquetes esenciales..."
sudo pacman -S --noconfirm git base-devel kitty rofi waybar fastfetch swww

# Instalar fish si se desea
read -p "¿Deseas instalar fish como shell (S/n)? " install_fish
install_fish=${install_fish:-S}
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  info "Instalando fish..."
  sudo pacman -S --noconfirm fish

  # Instalar Oh My Fish si se desea
  read -p "¿Deseas instalar Oh My Fish (omf) (S/n)? " install_omf
  install_omf=${install_omf:-S}
  if [[ "$install_omf" =~ ^[Ss]$ ]]; then
    info "Instalando Oh My Fish..."
    curl -L https://get.oh-my.fish | fish
    fish -c "omf install pj"
  fi
fi

# Instalar yay si se desea
read -p "¿Deseas instalar yay para gestionar paquetes de AUR (S/n)? " install_yay
install_yay=${install_yay:-S}
if [[ "$install_yay" =~ ^[Ss]$ ]]; then
  if ! command -v yay &> /dev/null; then
    info "Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
  else
    info "yay ya está instalado."
  fi
fi

# Copiar configuraciones
info "Copiando configuraciones desde $CONFIG_DIR a ~/.config..."
declare -A CONFIGS=(
  ["kitty"]="Kitty terminal"
  ["hypr"]="Hyprland"
  ["waybar"]="Waybar"
  ["fastfetch"]="Fastfetch"
  ["rofi"]="Rofi"
)

for dir in "${!CONFIGS[@]}"; do
  if [ -d "$CONFIG_DIR/$dir" ]; then
    info "Copiando ${CONFIGS[$dir]}..."
    cp -r "$CONFIG_DIR/$dir" ~/.config/
  else
    error "No se encontró la configuración de ${CONFIGS[$dir]} en $CONFIG_DIR."
  fi
done

# Configurar fish como shell por defecto si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  if ! grep -q "/usr/bin/fish" /etc/passwd; then
    info "Cambiando el shell predeterminado a fish..."
    chsh -s /usr/bin/fish
  else
    info "fish ya es el shell predeterminado."
  fi
fi

# Crear directorios de workspace
info "Creando directorios en ~/workspace..."
mkdir -p ~/workspace/{projects,documents,scripts}

success "Instalación y configuración completadas. Por favor, reinicia tu terminal para aplicar los cambios."
