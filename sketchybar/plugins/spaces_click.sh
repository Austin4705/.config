#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CURRENT=$(aerospace list-workspaces --focused 2>/dev/null)
args=(--remove '/spaces\.item\..*/' --set spaces popup.drawing=toggle)

COUNTER=0
for sid in $(aerospace list-workspaces --all 2>/dev/null); do
  COLOR=$GREY
  if [ "$sid" = "$CURRENT" ]; then
    COLOR=$WHITE
  fi
  args+=(--add item spaces.item.$COUNTER popup.spaces \
         --set spaces.item.$COUNTER label="$sid" \
                                    label.color="$COLOR" \
                                    click_script="aerospace workspace $sid && sketchybar --set spaces popup.drawing=off --set spaces label=$sid")
  COUNTER=$((COUNTER+1))
done

sketchybar -m "${args[@]}" > /dev/null
