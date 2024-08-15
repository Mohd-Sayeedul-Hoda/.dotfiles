#!/bin/bash

selected_dir=$(find "$HOME" -type d \( -name "node_modules" -o -name ".local" -o -name ".cache" -o -name ".rustup" -o -name ".npm" -o -name "personalBin" -o -name "nvim-linux64" -o -name ".vim" -o -name "go" -o -name ".rbenv" -o -name ".cargo" -o -name ".git" \) -prune -o -type d -print | fzy)

if [ -n "$selected_dir" ]; then
    cd "$selected_dir" || exit 1
    tmux new-session -c "$selected_dir"
fi
