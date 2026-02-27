#!/bin/bash

front_app=(
  icon.drawing=off
  label.font="$FONT:Black:13.0"
  associated_display=active
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=1
  background.drawing=on
  padding_left=5
  padding_right=5
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched \
                                mouse.entered  \
                                mouse.exited
