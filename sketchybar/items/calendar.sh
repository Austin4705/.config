#!/bin/bash

calendar=(
  icon.drawing=off
  label.font="$FONT:Semibold:13.0"
  label.align=right
  padding_left=8
  padding_right=10
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="open -a 'Calendar'"
)

sketchybar --add item calendar right          \
           --set calendar "${calendar[@]}"   \
           --subscribe calendar system_woke  \
                                mouse.entered \
                                mouse.exited
