#!/bin/bash
# Standard dev layout: editor on top (75%), terminal on bottom (25%)
# Usage: dev.sh [directory]

DIR="${1:-.}"
SESSION="dev"
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux kill-session -t "$SESSION"
fi

tmux new-session -d -s "$SESSION" -c "$DIR" -x "$(tput cols)" -y "$(tput lines)"
tmux send-keys -t "$SESSION" "nvim ." Enter
tmux split-window -v -t "$SESSION" -l 25% -c "$DIR"
tmux select-pane -t "$SESSION" -U
tmux attach -t "$SESSION"
