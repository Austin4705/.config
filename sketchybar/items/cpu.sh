#!/bin/bash

cpu_percent=(
  label.font="$FONT:Heavy:12"
  label=CPU
  icon=􀧓
  icon.font="$FONT:Bold:14.0"
  icon.color=$BLUE
  padding_left=5
  padding_right=0
  width=65
  update_freq=4
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  mach_helper="$HELPER"
)

cpu_graph=(
  graph.color=$BLUE
  graph.fill_color=$BLUE
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=on
  background.color=$TRANSPARENT
)

# Single combined graph - cpu.user receives data from the C helper
# (cpu.sys pushes are silently ignored since that item no longer exists)
sketchybar --add graph cpu.user right 50             \
           --set cpu.user "${cpu_graph[@]}"          \
                                                     \
           --add item cpu.percent right              \
           --set cpu.percent "${cpu_percent[@]}"     \
           --subscribe cpu.percent mouse.entered     \
                                   mouse.exited
