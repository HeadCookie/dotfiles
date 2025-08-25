#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(
    tmux list-sessions -F \#S | fzf --tmux center,50%
  )

fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

tmux switch -t "$selected_name"
