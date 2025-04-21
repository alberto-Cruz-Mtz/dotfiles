#!/bin/bash
hyprctl -j devices | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | sed \
  -e 's/English (US)/us/' \
  -e 's/Spanish (Latin American)/es/' \
  -e 's/Spanish (Latam)/latam/'
