#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if ! command -v SwitchAudioSource &>/dev/null; then
  open "x-apple.systempreferences:com.apple.Sound-Settings.extension"
  exit 0
fi

args=(--remove '/sound_output\.device\..*/' --set sound_output popup.drawing=toggle)
COUNTER=0
CURRENT="$(SwitchAudioSource -t output -c)"

while IFS= read -r device; do
  [ -z "$device" ] && continue
  COLOR=$GREY
  if [ "${device}" = "$CURRENT" ]; then
    COLOR=$WHITE
  fi
  args+=(--add item sound_output.device.$COUNTER popup.sound_output \
         --set sound_output.device.$COUNTER \
           label="${device}" \
           label.color="$COLOR" \
           click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /sound_output.device\.*/ label.color=$GREY --set \$NAME label.color=$WHITE --set sound_output popup.drawing=off && $CONFIG_DIR/plugins/sound_output.sh")
  COUNTER=$((COUNTER+1))
done <<< "$(SwitchAudioSource -a -t output)"

sketchybar -m "${args[@]}" > /dev/null
