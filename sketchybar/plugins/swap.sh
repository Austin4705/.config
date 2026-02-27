#!/bin/bash

source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered") sketchybar --set $NAME background.drawing=on; exit 0 ;;
  "mouse.exited")  sketchybar --set $NAME background.drawing=off; exit 0 ;;
esac

SWAP_USED=$(sysctl vm.swapusage 2>/dev/null | awk -F'used = ' '{print $2}' | awk '{printf "%.0f", $1}')
SWAP_UNIT=$(sysctl vm.swapusage 2>/dev/null | awk -F'used = ' '{print $2}' | awk '{print $2}' | tr -d ',')

if [ -z "$SWAP_USED" ]; then
  sketchybar --set $NAME label="--" label.color=$GREY
  exit 0
fi

SWAP_USED_INT=${SWAP_USED%.*}

if [ "$SWAP_USED_INT" -gt 1000 ] 2>/dev/null; then
  LABEL="$(echo "scale=1; $SWAP_USED / 1024" | bc)G"
  COLOR=$RED
elif [ "$SWAP_USED_INT" -gt 500 ] 2>/dev/null; then
  LABEL="${SWAP_USED_INT}M"
  COLOR=$ORANGE
elif [ "$SWAP_USED_INT" -gt 100 ] 2>/dev/null; then
  LABEL="${SWAP_USED_INT}M"
  COLOR=$YELLOW
elif [ "$SWAP_USED_INT" -gt 0 ] 2>/dev/null; then
  LABEL="${SWAP_USED_INT}M"
  COLOR=$LABEL_COLOR
else
  LABEL="0M"
  COLOR=$GREEN
fi

sketchybar --set $NAME label="$LABEL" label.color="$COLOR"
