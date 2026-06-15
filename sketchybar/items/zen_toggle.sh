#!/bin/bash

zen_toggle=(
  icon=􀂒
  icon.font="$FONT:Bold:14.0"
  icon.color=$GREY
  label.drawing=off
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  click_script="$PLUGIN_DIR/zen_toggle.sh"
)

sketchybar --add item zen_toggle left                  \
           --set zen_toggle "${zen_toggle[@]}"         \
           --subscribe zen_toggle mouse.entered        \
                                  mouse.exited
