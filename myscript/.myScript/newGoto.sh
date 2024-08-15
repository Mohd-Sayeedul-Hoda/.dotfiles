#!/bin/bash

selected_dir=$(fd -H --base-directory="$HOME"  --type directory --ignore-file .myScript/ignoreFile.txt | fzy)
if [ -n "$selected_dir" ]; then
    z "$HOME/$selected_dir" || { echo "Failed to change directory." >&2; exit 1; }
fi
