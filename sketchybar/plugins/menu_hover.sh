#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.color=$HIGHLIGHT_COLOR ;;
  "mouse.exited")  sketchybar --set $NAME background.color=$BACKGROUND_1 ;;
esac
