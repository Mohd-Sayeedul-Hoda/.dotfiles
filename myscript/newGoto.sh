#!/bin/bash

selected_dir=$(fd -H --base-directory=/home/aman  --type directory --ignore-file .myScript/ignoreFile.txt | fzy)
if [ -n "$selected_dir" ]; then
    cd "/home/aman/$selected_dir" || { echo "Failed to change directory." >&2; exit 1; }
fi
