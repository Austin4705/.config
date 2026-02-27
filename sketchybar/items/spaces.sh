#!/bin/bash

sketchybar --add event aerospace_workspace_change
spaces=()
echo $(aerospace list-workspaces --all)
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon="$sid" \
        icon.padding_left=10 \
        icon.padding_right=10 \
        padding_left=2 \
        padding_right=2 \
        label.padding_right=20 \
        icon.highlight_color=$RED \
        label.color=$GREY \
        label.highlight_color=$WHITE \
        label.font="sketchybar-app-font:Regular:16.0" \
        label.y_offset=-1 \
        background.color=$BACKGROUND_1 \
        background.border_color=$BACKGROUND_2 \
        background.drawing=off \
        label.drawing=off \
        script="$PLUGIN_DIR/aerospace.sh $sid" \
        click_script="aerospace workspace $sid"

done

spaces_bracket=(
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
)

sketchybar --add bracket spaces_bracket '/space\..*/' \
    --set spaces_bracket "${spaces_bracket[@]}"
