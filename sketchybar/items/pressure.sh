#!/bin/bash

pressure=(
  icon=MEM
  icon.font="$FONT:Bold:10.0"
  icon.color=$GREEN
  label="--"
  label.font="$FONT:Heavy:12"
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/pressure.sh"
)

sketchybar --add item pressure right               \
           --set pressure "${pressure[@]}"         \
           --subscribe pressure mouse.entered      \
                               mouse.exited
