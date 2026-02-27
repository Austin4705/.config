#!/bin/bash

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.drawing=on; exit 0 ;;
  "mouse.exited")  sketchybar --set $NAME background.drawing=off; exit 0 ;;
esac

TMPFILE="/tmp/sketchybar_network"
INTERFACE="en0"

CURRENT=$(netstat -I "$INTERFACE" -b 2>/dev/null | tail -1)
if [ -z "$CURRENT" ]; then
  sketchybar --set $NAME label="↓0K ↑0K"
  exit 0
fi

CURRENT_IN=$(echo "$CURRENT" | awk '{print $7}')
CURRENT_OUT=$(echo "$CURRENT" | awk '{print $10}')
CURRENT_TIME=$(date +%s)

if [ -f "$TMPFILE" ]; then
  PREV_IN=$(awk 'NR==1' "$TMPFILE")
  PREV_OUT=$(awk 'NR==2' "$TMPFILE")
  PREV_TIME=$(awk 'NR==3' "$TMPFILE")

  ELAPSED=$((CURRENT_TIME - PREV_TIME))
  if [ "$ELAPSED" -gt 0 ] 2>/dev/null; then
    DL_SPEED=$(( (CURRENT_IN - PREV_IN) / ELAPSED ))
    UL_SPEED=$(( (CURRENT_OUT - PREV_OUT) / ELAPSED ))
  else
    DL_SPEED=0
    UL_SPEED=0
  fi
else
  DL_SPEED=0
  UL_SPEED=0
fi

echo "$CURRENT_IN" > "$TMPFILE"
echo "$CURRENT_OUT" >> "$TMPFILE"
echo "$CURRENT_TIME" >> "$TMPFILE"

format_speed() {
  local bytes=$1
  if [ "$bytes" -ge 1073741824 ] 2>/dev/null; then
    echo "$(echo "scale=1; $bytes / 1073741824" | bc)G"
  elif [ "$bytes" -ge 1048576 ] 2>/dev/null; then
    echo "$(echo "scale=1; $bytes / 1048576" | bc)M"
  elif [ "$bytes" -ge 1024 ] 2>/dev/null; then
    echo "$(( bytes / 1024 ))K"
  else
    echo "0K"
  fi
}

DL_FMT=$(format_speed "$DL_SPEED")
UL_FMT=$(format_speed "$UL_SPEED")

sketchybar --set $NAME label="↓${DL_FMT} ↑${UL_FMT}"
