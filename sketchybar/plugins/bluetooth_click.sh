#!/bin/bash

# Open native macOS Bluetooth dropdown (uses description, not name)
osascript 2>/dev/null <<'EOF'
tell application "System Events"
  tell process "ControlCenter"
    repeat with i from 1 to (count of menu bar items of menu bar 1)
      if description of menu bar item i of menu bar 1 contains "Bluetooth" then
        click menu bar item i of menu bar 1
        return
      end if
    end repeat
  end tell
end tell
EOF

if [ $? -ne 0 ]; then
  open "x-apple.systempreferences:com.apple.BluetoothSettings"
fi
