#!/bin/bash

DIRS=(
    "$HOME/Documents/dotfiles"
    "$HOME/Documents/docs"
    "$HOME/Documents/projects"
    "$HOME/Documents/work"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find . "${DIRS[@]}" -type d -maxdepth 1 \
        | sed "s|^$HOME/||" \
        | fzf)

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
