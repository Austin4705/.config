#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "mouse.entered")
    sketchybar --set $NAME background.drawing=on
    exit 0
    ;;
  "mouse.exited")
    sketchybar --set $NAME background.drawing=off
    exit 0
    ;;
esac

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I 2>/dev/null | awk '/ SSID/ {print $NF}')

if [ -z "$SSID" ]; then
  SSID=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')
fi

if [ -n "$SSID" ] && [ "$SSID" != "You are not associated with an AirPort network." ]; then
  sketchybar --set $NAME icon=$WIFI_ON icon.color=$WHITE
else
  sketchybar --set $NAME icon=$WIFI_OFF icon.color=$GREY
fi
