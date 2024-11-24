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
echo "Actualizando el sistema y sincronizando la base de datos de paquetes..."
sudo pacman -Syu --noconfirm
clear

# Instalar paquetes necesarios
echo "Instalando paquetes esenciales..."
sudo pacman -S --noconfirm git base-devel kitty rofi waybar fastfetch swww
clear

# Instalar Fish y Oh My Fish (opcional)
read -p "¿Deseas instalar fish como shell (S/n)? " install_fish
install_fish=${install_fish:-S}
clear

if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  echo "Instalando fish..."
  sudo pacman -S --noconfirm fish
  clear

  read -p "¿Deseas instalar Oh My Fish (OMF) (S/n)? " install_omf
  install_omf=${install_omf:-S}
  clear

  if [[ "$install_omf" =~ ^[Ss]$ ]]; then
    echo "Instalando Oh My Fish (OMF)..."
    curl -L https://get.oh-my.fish | fish
    fish -c "omf install pj"
    clear
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
clear

# Instalar paquetes adicionales con yay
echo "Instalando paquetes de AUR con yay..."
yay -S --noconfirm waypaper python-screeninfo python-imageio
clear

# Copiar configuraciones desde el directorio proporcionado
echo "Copiando configuraciones desde $CONFIG_DIR/config"
cp -r $CONFIG_DIR/config/kitty ~/.config/
cp -r $CONFIG_DIR/config/hypr ~/.config/
cp -r $CONFIG_DIR/config/waybar ~/.config/
cp -r $CONFIG_DIR/config/fastfetch ~/.config/
cp -r $CONFIG_DIR/config/rofi ~/.config/
cp -r $CONFIG_DIR/config/waypaper ~/.config/
clear

# Copiar configuraciones de fish si se seleccionó
if [[ "$install_fish" =~ ^[Ss]$ ]]; then
  echo "Copiando configuraciones de fish..."
  cp -r $CONFIG_DIR/config/fish ~/.config/
  chsh -s /usr/bin/fish
  clear
fi

# Crear directorios de workspace en /home
echo "Creando directorios de trabajo..."
mkdir -p ~/workspace/{projects,documents,scripts}
clear

# Finalizar con opción de reinicio
read -p "¿Deseas reiniciar el sistema ahora? (S/n): " restart_now
restart_now=${restart_now:-S}

if [[ "$restart_now" =~ ^[Ss]$ ]]; then
  echo "Reiniciando el sistema..."
  sudo reboot
else
  echo "Instalación y configuración completadas. Por favor, reinicia el sistema manualmente más tarde."
fi
