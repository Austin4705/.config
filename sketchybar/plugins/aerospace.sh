#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh"
COLOR=$BACKGROUND_2
SELECTED="false"
echo "input $1 focused workspace $FOCUSED_WORKSPACE"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME icon.highlight=true \
        label.highlight=true \
        background.border_color=$BACKGROUND_2
else
    sketchybar --set $NAME icon.highlight=false \
        label.highlight=false \
        background.border_color=$GRAY
fi
