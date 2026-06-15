#!/bin/bash

FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null || echo "?")

get_desc() {
  case "$1" in
    A) echo "AI & Research" ;; B) echo "Calendar" ;; C) echo "Chat" ;;
    D) echo "Downloads" ;; F) echo "System" ;; G) echo "CAD" ;;
    M) echo "Music" ;; Q) echo "Notes" ;; R) echo "Maps" ;;
    S) echo "Preview" ;; V) echo "Code" ;; W) echo "Chrome" ;;
    X) echo "Terminal" ;; Z) echo "Zen" ;; *) echo "" ;;
  esac
}

DESC=$(get_desc "$FOCUSED")
INIT_LABEL="$FOCUSED"
[ -n "$DESC" ] && INIT_LABEL="$FOCUSED — $DESC"

spaces_item=(
  icon="Spaces:"
  icon.font="$FONT:Bold:13.0"
  icon.color=$LABEL_COLOR
  label="$INIT_LABEL"
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
