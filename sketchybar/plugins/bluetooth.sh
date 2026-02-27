#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.drawing=on; exit 0 ;;
  "mouse.exited")  sketchybar --set $NAME background.drawing=off; exit 0 ;;
esac

if command -v blueutil &>/dev/null; then
  POWER=$(blueutil --power)
  if [ "$POWER" -eq 1 ]; then
    CONNECTED=$(blueutil --connected --format json 2>/dev/null | grep -c '"name"')
    if [ "$CONNECTED" -gt 0 ] 2>/dev/null; then
      sketchybar --set $NAME icon.color=$BLUE icon="BT:${CONNECTED}"
    else
      sketchybar --set $NAME icon.color=$WHITE icon="BT"
    fi
  else
    sketchybar --set $NAME icon.color=$GREY icon="BT"
  fi
else
  sketchybar --set $NAME icon.color=$WHITE icon="BT"
fi
