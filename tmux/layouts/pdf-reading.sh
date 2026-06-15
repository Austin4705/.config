#!/bin/bash
# Open a tex/typst file in nvim (70%) with its compiled PDF in tdf (30%)
# Usage: pdf-reading.sh [pdf_file]
#   If no argument, prompts for a file.

PDF="${1:?Usage: pdf-reading.sh <file.pdf>}"
SRC="${PDF%.*}.tex"
[ ! -f "$SRC" ] && SRC="${PDF%.*}.typ"
[ ! -f "$SRC" ] && SRC="$PDF"

SESSION="pdf-read"
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux kill-session -t "$SESSION"
fi

tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)"
tmux send-keys -t "$SESSION" "nvim $SRC" Enter
tmux split-window -h -t "$SESSION" -l 30%
tmux send-keys -t "$SESSION" "tdf $PDF" Enter
tmux select-pane -t "$SESSION" -L
tmux attach -t "$SESSION"
