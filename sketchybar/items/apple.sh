#!/bin/bash

apple_logo=(
  icon=$APPLE
  icon.font="$FONT:Black:16.0"
  icon.color=$GREEN
  padding_right=5
  padding_left=7
  label.drawing=off
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  click_script="osascript -e 'tell application \"System Events\" to click menu bar item 1 of menu bar 1 of (first process whose frontmost is true)'"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
           --subscribe apple.logo mouse.entered        \
                                  mouse.exited
