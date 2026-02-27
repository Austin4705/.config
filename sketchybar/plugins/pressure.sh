#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.drawing=on; exit 0 ;;
  "mouse.exited")  sketchybar --set $NAME background.drawing=off; exit 0 ;;
esac

LABEL=""
COLOR=$LABEL_COLOR

LEVEL=$(sysctl -n kern.memorystatus_vm_pressure_level 2>/dev/null)

if [ -n "$LEVEL" ]; then
  case "$LEVEL" in
    1) LABEL="OK";   COLOR=$GREEN ;;
    2) LABEL="Warn"; COLOR=$YELLOW ;;
    4) LABEL="Crit"; COLOR=$RED ;;
    *) LABEL="?";    COLOR=$GREY ;;
  esac
else
  FREE_PCT=$(memory_pressure 2>/dev/null | awk '/System-wide memory free percentage/ {print $NF}' | tr -d '%')
  if [ -n "$FREE_PCT" ]; then
    if   [ "$FREE_PCT" -gt 40 ]; then LABEL="OK ${FREE_PCT}%";   COLOR=$GREEN
    elif [ "$FREE_PCT" -gt 20 ]; then LABEL="Warn ${FREE_PCT}%"; COLOR=$YELLOW
    elif [ "$FREE_PCT" -gt 10 ]; then LABEL="High ${FREE_PCT}%"; COLOR=$ORANGE
    else                               LABEL="Crit ${FREE_PCT}%"; COLOR=$RED
    fi
  else
    LABEL="--"; COLOR=$GREY
  fi
fi

sketchybar --set $NAME label="$LABEL" label.color="$COLOR"
