#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  label.font="$FONT:Semibold:11.0"
  label.drawing=on
  padding_right=5
  padding_left=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=120
  updates=on
)

sketchybar --add item battery right             \
           --set battery "${battery[@]}"        \
           --subscribe battery power_source_change \
                               system_woke      \
                               mouse.entered    \
                               mouse.exited
