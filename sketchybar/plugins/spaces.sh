#!/bin/bash

case "$SENDER" in
  "aerospace_workspace_change")
    FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")
    sketchybar --set $NAME label="$FOCUSED"
    ;;
  "mouse.entered")
    sketchybar --set $NAME background.drawing=on
    ;;
  "mouse.exited")
    sketchybar --set $NAME background.drawing=off
    ;;
esac
