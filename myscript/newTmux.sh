#!/bin/bash

selected_dir=$(fd -H --base-directory=/home/aman  --type directory --ignore-file .myScript/ignoreFile.txt | fzy)
if [ -n "$selected_dir" ]; then
    cd "/home/aman/$selected_dir" || exit 1
    current_dir=$(pwd)
    tmux new-session -c "$current_dir"
fi
