#!/bin/bash

wifi=(
  icon=$WIFI_ON
  icon.font="$FONT:Regular:16.0"
  label.drawing=off
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  update_freq=30
  script="$PLUGIN_DIR/wifi.sh"
  click_script="$PLUGIN_DIR/wifi_click.sh"
)

sketchybar --add item wifi right            \
           --set wifi "${wifi[@]}"          \
           --subscribe wifi wifi_change     \
                            system_woke     \
                            mouse.entered   \
                            mouse.exited
