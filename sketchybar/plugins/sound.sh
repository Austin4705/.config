#!/usr/bin/env sh

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [[ $MUTED != "false" ]]; then
ICON="􀊢"
else
case ${VOLUME} in
  100) ICON="􀊨";;
  [7-9][0-9]) ICON="􀊨";;
  [3-6][0-9]) ICON="􀊦";;
  [0-2][0-9]) ICON="􀊤";;
  [0-9]) ICON="􀊤";;
  *) ICON="􀊠"
esac
fi

sketchybar -m \
--set $NAME icon=$ICON \
--set $NAME label="$VOLUME%"
