#!/bin/bash

source "$CONFIG_DIR/colors.sh"

get_desc() {
  case "$1" in
    1) echo "General" ;; 2) echo "Screen Share" ;; 3) echo "General" ;; 4) echo "General" ;;
    A) echo "AI & Research" ;; B) echo "Calendar" ;; C) echo "Chat" ;; D) echo "Downloads" ;;
    F) echo "System" ;; G) echo "CAD" ;; M) echo "Music" ;; Q) echo "Notes" ;;
    R) echo "Maps" ;; S) echo "Preview" ;; V) echo "Code" ;; W) echo "Chrome" ;;
    X) echo "Terminal" ;; Z) echo "Zen" ;; *) echo "" ;;
  esac
}

CURRENT=$(aerospace list-workspaces --focused 2>/dev/null)
ALL_WS=$(aerospace list-workspaces --all 2>/dev/null)

args=(--remove '/spaces\.ws\..*/' --remove '/spaces\.win\..*/' --set spaces popup.drawing=toggle)

for sid in $ALL_WS; do
  WINDOWS=$(aerospace list-windows --workspace "$sid" --format '%{app-name}|%{window-id}' 2>/dev/null)

  [ -z "$WINDOWS" ] && [ "$sid" != "$CURRENT" ] && continue

  DESC=$(get_desc "$sid")
  HEADER="$sid"
  [ -n "$DESC" ] && HEADER="$sid — $DESC"

  HEADER_COLOR=$GREY
  if [ "$sid" = "$CURRENT" ]; then
    HEADER="● $HEADER"
    HEADER_COLOR=$GREEN
  fi

  # Build app list for this workspace
  APP_LIST=""
  if [ -n "$WINDOWS" ]; then
    while IFS='|' read -r app_name window_id; do
      [ -z "$app_name" ] && continue
      if [ -z "$APP_LIST" ]; then
        APP_LIST="$app_name"
      else
        APP_LIST="$APP_LIST, $app_name"
      fi
    done <<< "$WINDOWS"
  fi

  # Combine header + apps on one line
  if [ -n "$APP_LIST" ]; then
    FULL_LABEL="$HEADER:  $APP_LIST"
  else
    FULL_LABEL="$HEADER:  (empty)"
  fi

  args+=(--add item spaces.ws.$sid popup.spaces \
         --set spaces.ws.$sid \
           label="$FULL_LABEL" \
           label.font="SF Pro:Bold:13.0" \
           label.color="$HEADER_COLOR" \
           icon.drawing=off \
           click_script="aerospace workspace $sid && sketchybar --set spaces popup.drawing=off --set spaces label='$sid'")
done

sketchybar -m "${args[@]}" > /dev/null
