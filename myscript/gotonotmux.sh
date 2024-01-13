#!/bin/bash

selected_dir=$(find "$HOME" -type d \( -name "node_modules" -o -name ".local" -o -name ".cache" -o -name ".rustup" -o -name ".npm" -o -name "personalBin" -o -name "nvim-linux64" -o -name ".vim" -o -name "go" -o -name ".rbenv" -o -name ".cargo" -name ".git" -name ".cargo" \) -prune -o -type d -print | fzy)

if [ -n "$selected_dir" ]; then
    cd "$selected_dir" || { echo "Failed to change directory." >&2; exit 1; }
fi
