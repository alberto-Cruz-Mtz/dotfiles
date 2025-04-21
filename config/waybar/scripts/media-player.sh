#!/bin/bash

# Requiere: playerctl (para controlar reproductores MPRIS)
PLAYER=$(playerctl -l | grep -E 'spotify|firefox|mpd' | head -n 1)
PLAYER_STATUS=$(playerctl -p "$PLAYER" status)

if [ "$PLAYER_STATUS" = "Playing" ]; then
  ARTIST=$(playerctl metadata artist)
  TITLE=$(playerctl metadata title)
  echo "{\"text\": $TITLE\", \"class\": \"playing\"}"
elif [ "$PLAYER_STATUS" = "Paused" ]; then
  echo "{\"text\": \"Paused\", \"class\": \"paused\"}"
else
  echo "{\"text\": \"No media\", \"class\": \"stopped\"}"
fi
