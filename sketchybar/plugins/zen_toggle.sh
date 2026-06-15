#!/bin/bash

VISIBLE=$(sketchybar --query front_app 2>/dev/null | jq -r '.geometry.drawing')

if [ "$VISIBLE" = "off" ]; then
  # Zen OFF — show everything, icon goes grey hollow square
  sketchybar --set front_app drawing=on \
             --set '/menu\.item\..*/' drawing=on \
             --set spaces drawing=on \
             --set calendar drawing=on \
             --set wifi drawing=on \
             --set sound_output drawing=on \
             --set volume drawing=on \
             --set volume_icon drawing=on \
             --set bluetooth drawing=on \
             --set network drawing=on \
             --set swap drawing=on \
             --set pressure drawing=on \
             --set cpu.percent drawing=on \
             --set cpu.user drawing=on \
             --set battery label.drawing=on \
             --set zen_toggle icon=􀂒 icon.color=0xff939ab7

  # Re-run battery script to restore color-coded icon/label
  sketchybar --trigger power_source_change
else
  # Zen ON — hide items, icon goes green filled square
  sketchybar --set front_app drawing=off \
             --set '/menu\.item\..*/' drawing=off \
             --set spaces drawing=off \
             --set calendar drawing=off \
             --set wifi drawing=off \
             --set sound_output drawing=off \
             --set bluetooth drawing=off \
             --set network drawing=off \
             --set swap drawing=off \
             --set pressure drawing=off \
             --set cpu.percent drawing=off \
             --set cpu.user drawing=off \
             --set battery label.drawing=off icon.color=0xffcad3f5 label.color=0xffcad3f5 \
             --set zen_toggle icon=􀂓 icon.color=0xffa6da95
fi
