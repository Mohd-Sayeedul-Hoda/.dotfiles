#!/bin/bash

selected_dir=$(fd -H --base-directory="$HOME"  --type file --ignore-file .myScript/ignoreFile.txt | fzy)
if [ -n "$selected_dir" ]; then
    nvim "$HOME/$selected_dir" || { echo "Failed to open the file" >&2; exit 1; }
fi
