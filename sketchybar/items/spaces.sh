#!/bin/bash

FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")

spaces_item=(
  icon="Spaces:"
  icon.font="$FONT:Bold:13.0"
  icon.color=$LABEL_COLOR
  label="$FOCUSED"
  label.font="$FONT:Heavy:13.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  popup.height=30
  script="$PLUGIN_DIR/spaces.sh"
  click_script="$PLUGIN_DIR/spaces_click.sh"
)

sketchybar --add item spaces left                    \
           --set spaces "${spaces_item[@]}"          \
           --subscribe spaces aerospace_workspace_change \
                              mouse.entered          \
                              mouse.exited
