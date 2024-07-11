#!/bin/bash

selected_dir=$(fd -H --base-directory=/home/aman  --type directory --ignore-file .myScript/ignoreFile.txt | fzy)
if [ -n "$selected_dir" ]; then
    cd "$selected_dir" || exit 1
    tmux new-session -c "$selected_dir"
fi
