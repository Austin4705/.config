#!/bin/bash

INITIAL_OUTPUT=$(SwitchAudioSource -t output -c 2>/dev/null || echo "--")
if [ ${#INITIAL_OUTPUT} -gt 14 ]; then
  INITIAL_OUTPUT="${INITIAL_OUTPUT:0:12}.."
fi

sound_output=(
  icon=OUT
  icon.font="$FONT:Bold:10.0"
  icon.color=$MAGENTA
  label="$INITIAL_OUTPUT"
  label.font="$FONT:Semibold:11"
  padding_left=5
  padding_right=5
  background.color=$HIGHLIGHT_COLOR
  background.drawing=off
  popup.height=30
  updates=on
  update_freq=10
  script="$PLUGIN_DIR/sound_output.sh"
  click_script="$PLUGIN_DIR/sound_output_click.sh"
)

sketchybar --add item sound_output right                 \
           --set sound_output "${sound_output[@]}"       \
           --subscribe sound_output mouse.entered        \
                                    mouse.exited
