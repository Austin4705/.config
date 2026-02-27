#!/bin/bash

bluetooth=(
  icon=BT
  icon.font="$FONT:Bold:13.0"
  icon.color=$BLUE
  label.drawing=off
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=30
  script="$PLUGIN_DIR/bluetooth.sh"
  click_script="$PLUGIN_DIR/bluetooth_click.sh"
)

sketchybar --add item bluetooth right                \
           --set bluetooth "${bluetooth[@]}"         \
           --subscribe bluetooth mouse.entered       \
                                 mouse.exited
