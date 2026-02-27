#!/bin/bash

swap=(
  icon=SWP
  icon.font="$FONT:Bold:10.0"
  icon.color=$ORANGE
  label="0M"
  label.font="$FONT:Heavy:12"
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/swap.sh"
)

sketchybar --add item swap right           \
           --set swap "${swap[@]}"         \
           --subscribe swap mouse.entered  \
                            mouse.exited
