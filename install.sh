#!/bin/bash

# Script de instalación para Arch Linux

# Verificar si se proporcionó un directorio de configuración
if [ -z "$1" ]; then
  echo "Por favor, proporciona el directorio de configuración como argumento."
  echo "Uso: ./install.sh /ruta/al/directorio/de/configuracion"
  exit 1
fi

CONFIG_DIR=$1

# Actualizar y sincronizar la base de datos de paquetes
sudo pacman -Syu --noconfirm

# Instalar paquetes necesarios
sudo pacman -S --noconfirm git base-devel kitty rofi waybar fastfetch swww

# Preguntar si se desea instalar fish
read -p "¿Deseas instalar fish como shell (S/n)? " install_fish
install_fish=${install_fish:-S}

# Instalar fish si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  sudo pacman -S --noconfirm fish

  # Preguntar si se desea instalar Oh My Fish
  read -p "¿Deseas instalar Oh My Fish (omf) (S/n)? " install_omf
  install_omf=${install_omf:-S}

  if [[ "$install_omf" =~ ^[Ss]$ ]]; then
    # Instalar Oh My Fish
    curl -L https://get.oh-my.fish | fish

    # Instalar tema pj con Oh My Fish
    fish -c "omf install pj"
  fi
fi

# Preguntar si se desea instalar yay
read -p "¿Deseas instalar yay para gestionar paquetes de AUR (S/n)? " install_yay
install_yay=${install_yay:-S}

# Instalar AUR helper (yay) si se seleccionó
if [[ "$install_yay" =~ ^[Ss]$ ]]; then
  if ! command -v yay &> /dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
  fi
fi

# Copiar configuraciones
echo "Copiando configuraciones desde $CONFIG_DIR/.config"
cp -r $CONFIG_DIR/.config/kitty ~/.config/
cp -r $CONFIG_DIR/.config/hypr ~/.config/
cp -r $CONFIG_DIR/.config/waybar ~/.config/
cp -r $CONFIG_DIR/.config/fastfetch ~/.config/
cp -r $CONFIG_DIR/.config/rofi ~/.config/

# Copiar configuraciones de fish si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  cp -r $CONFIG_DIR/.config/fish ~/.config/
  # Cambiar shell por defecto a fish
  chsh -s /usr/bin/fish
fi

# Crear directorios de workspace en /home
mkdir -p ~/workspace/{projects,documents,scripts}

echo "Instalación y configuración completadas. Por favor, reinicia tu terminal para aplicar los cambios."

