#!/usr/bin/env bash
PROJECTS_DIR="/Volumes/Projects"

projects=$(fd . "$PROJECTS_DIR" -d 1 -t d | sed "s|^$PROJECTS_DIR/||" | sed 's:/*$::')

sessions=$(tmux list-sessions -F '#S' 2>/dev/null || true)

selected=$(echo -e "${projects}\n${sessions}" | sort -u | fzf --tmux center,50%)

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(echo "$selected" | tr . _)

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  if [[ -d "$PROJECTS_DIR/$selected" ]]; then
    tmux new-session -s "$selected_name" -c "$PROJECTS_DIR/$selected"
  else
    tmux new-session -s "$selected_name"
  fi
  exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$PROJECTS_DIR/$selected"
fi

if [[ -n "$TMUX" ]]; then
  tmux switch-client -t "$selected_name"
else
  tmux attach-session -t "$selected_name"
fi
