#!/bin/bash

PROCESS="$1"
MENU="$2"

osascript <<EOF
tell application "System Events"
  tell process "$PROCESS"
    click menu bar item "$MENU" of menu bar 1
  end tell
end tell
EOF
