#!/bin/bash
SCREENSHOT="/tmp/hyprlock-blur-dark.png"

# Capturar pantalla y aplicar efectos
grim - |
  convert - -filter Gaussian \
    -resize 20% \
    -define filter:sigma=1.5 \
    -resize 500% \
    -fill black -colorize 40% \
    -brightness-contrast -10x0 \
    "$SCREENSHOT"

# Actualizar fondo de Hyprlock
sed -i "s|^background {.*|background { path = $SCREENSHOT }|" ~/.config/hypr/hyprlock.conf
