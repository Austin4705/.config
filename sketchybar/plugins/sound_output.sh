#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.drawing=on; exit 0 ;;
  "mouse.exited")  sketchybar --set $NAME background.drawing=off; exit 0 ;;
esac

if command -v SwitchAudioSource &>/dev/null; then
  CURRENT=$(SwitchAudioSource -t output -c 2>/dev/null)
  if [ ${#CURRENT} -gt 14 ]; then
    DISPLAY_NAME="${CURRENT:0:12}.."
  else
    DISPLAY_NAME="$CURRENT"
  fi
  sketchybar --set $NAME label="$DISPLAY_NAME"
else
  sketchybar --set $NAME label="--"
fi
