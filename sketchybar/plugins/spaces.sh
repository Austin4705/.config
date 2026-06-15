#!/bin/bash

get_desc() {
  case "$1" in
    1) echo "General" ;;
    2) echo "Screen Share" ;;
    3) echo "General" ;;
    4) echo "General" ;;
    A) echo "AI & Research" ;;
    B) echo "Calendar" ;;
    C) echo "Chat" ;;
    D) echo "Downloads" ;;
    F) echo "System" ;;
    G) echo "CAD" ;;
    M) echo "Music" ;;
    Q) echo "Notes" ;;
    R) echo "Maps" ;;
    S) echo "Preview" ;;
    V) echo "Code" ;;
    W) echo "Chrome" ;;
    X) echo "Terminal" ;;
    Z) echo "Zen" ;;
    *) echo "" ;;
  esac
}

case "$SENDER" in
  "aerospace_workspace_change")
    FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")
    DESC=$(get_desc "$FOCUSED")
    if [ -n "$DESC" ]; then
      sketchybar --set $NAME label="$FOCUSED — $DESC"
    else
      sketchybar --set $NAME label="$FOCUSED"
    fi
    ;;
  "mouse.entered")
    sketchybar --set $NAME background.drawing=on
    ;;
  "mouse.exited")
    sketchybar --set $NAME background.drawing=off
    ;;
esac
