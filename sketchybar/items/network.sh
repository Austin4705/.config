#!/bin/bash

network=(
  icon=NET
  icon.font="$FONT:Bold:10.0"
  icon.color=$YELLOW
  label="↓0K ↑0K"
  label.font="$FONT:Semibold:11"
  padding_left=5
  padding_right=10
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=3
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right              \
           --set network "${network[@]}"         \
           --subscribe network mouse.entered     \
                               mouse.exited
