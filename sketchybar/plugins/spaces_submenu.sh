#!/bin/bash

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME popup.drawing=on ;;
  "mouse.exited")  sketchybar --set $NAME popup.drawing=off ;;
esac
