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

# Instalar Fish y Oh My Fish (opcional)
read -p "¿Deseas instalar fish como shell (S/n)? " install_fish
install_fish=${install_fish:-S}

if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  sudo pacman -S --noconfirm fish

  read -p "¿Deseas instalar Oh My Fish (OMF) (S/n)? " install_omf
  install_omf=${install_omf:-S}

  if [[ "$install_omf" =~ ^[Ss]$ ]]; then
    curl -L https://get.oh-my.fish | fish
    fish -c "omf install pj"
  fi
fi

# Instalar yay para gestionar paquetes de AUR
echo "Instalando yay para gestionar paquetes de AUR..."
if ! command -v yay &> /dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

# Instalar paquetes adicionales con yay
echo "Instalando paquetes de AUR con yay..."
yay -S --noconfirm waypaper python-screeninfo python-imageio

# Copiar configuraciones desde el directorio proporcionado
echo "Copiando configuraciones desde $CONFIG_DIR/.config"
cp -r $CONFIG_DIR/.config/kitty ~/.config/
cp -r $CONFIG_DIR/.config/hypr ~/.config/
cp -r $CONFIG_DIR/.config/waybar ~/.config/
cp -r $CONFIG_DIR/.config/fastfetch ~/.config/
cp -r $CONFIG_DIR/.config/rofi ~/.config/
cp -r $CONFIG_DIR/.config/waypaper ~/.config/
cp -r $CONFIG_DIR/.config/wallpaper ~/.config/

# Copiar configuraciones de fish si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  cp -r $CONFIG_DIR/.config/fish ~/.config/
  chsh -s /usr/bin/fish
fi

# Crear directorios de workspace en /home
mkdir -p ~/workspace/{projects,documents,scripts}

echo "Instalación y configuración completadas. Por favor, reinicia tu terminal para aplicar los cambios."
