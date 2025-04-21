#!/bin/bash
# Obtiene el nombre del teclado principal
device=$(hyprctl -j devices | jq -r '.keyboards[] | select(.main == true) | .name')

# Cambia el layout del teclado principal
hyprctl switchxkblayout "$device" next
