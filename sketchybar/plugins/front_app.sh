#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CACHE_DIR="/tmp/sketchybar_menu_cache"
mkdir -p "$CACHE_DIR" 2>/dev/null

create_menu_items() {
  APP="$INFO"

  if [ ${#APP} -gt 20 ]; then
    sketchybar --set $NAME label="${APP:0:18}..."
  else
    sketchybar --set $NAME label="$APP"
  fi

  sketchybar --remove '/menu\.item\..*/' 2>/dev/null

  CACHE_KEY=$(echo "$APP" | tr ' /.' '___')
  CACHE_FILE="$CACHE_DIR/$CACHE_KEY"

  if [ -f "$CACHE_FILE" ]; then
    MENU_DATA=$(cat "$CACHE_FILE")
  else
    MENU_DATA=$(osascript 2>/dev/null <<'APPLESCRIPT'
tell application "System Events"
  set fp to first process whose frontmost is true
  set pn to name of fp
  set mn to name of every menu bar item of menu bar 1 of fp
  set o to pn
  repeat with m in mn
    if m is not missing value then set o to o & linefeed & m
  end repeat
  return o
end tell
APPLESCRIPT
    )
    [ -n "$MENU_DATA" ] && echo "$MENU_DATA" > "$CACHE_FILE"
  fi

  [ -z "$MENU_DATA" ] && return

  PROCESS=$(echo "$MENU_DATA" | head -1)
  [ -z "$PROCESS" ] && return

  sketchybar --set front_app \
    click_script="$CONFIG_DIR/plugins/click_menu.sh '$PROCESS' '$APP'"

  COUNTER=0
  REORDER="apple.logo front_app"

  while IFS= read -r menu_name; do
    [ -z "$menu_name" ] && continue
    [ "$menu_name" = "Apple" ] && continue
    [ "$menu_name" = "$APP" ] && continue

    ITEM_NAME="menu.item.$COUNTER"
    REORDER="$REORDER $ITEM_NAME"

    sketchybar --add item "$ITEM_NAME" left \
               --set "$ITEM_NAME" \
                 label="$menu_name" \
                 label.font="SF Pro:Semibold:13.0" \
                 label.color=$LABEL_COLOR \
                 icon.drawing=off \
                 padding_left=3 \
                 padding_right=3 \
                 background.color=$BACKGROUND_1 \
                 background.border_color=$BACKGROUND_2 \
                 background.border_width=1 \
                 background.corner_radius=9 \
                 background.height=26 \
                 background.drawing=on \
                 script="$CONFIG_DIR/plugins/menu_hover.sh" \
                 click_script="$CONFIG_DIR/plugins/click_menu.sh '$PROCESS' '$menu_name'" \
               --subscribe "$ITEM_NAME" mouse.entered mouse.exited

    COUNTER=$((COUNTER+1))
  done <<< "$(echo "$MENU_DATA" | tail -n +2)"

  REORDER="$REORDER spaces"
  sketchybar --reorder $REORDER 2>/dev/null
}

case "$SENDER" in
  "front_app_switched")
    create_menu_items
    ;;
  "mouse.entered")
    sketchybar --set $NAME background.color=$HIGHLIGHT_COLOR
    ;;
  "mouse.exited")
    sketchybar --set $NAME background.color=$BACKGROUND_1
    ;;
esac
