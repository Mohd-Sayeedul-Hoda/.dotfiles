#!/bin/bash

tree=$(git worktree list | sed -E 's/\s.*//g' | fzy)
if [ -n "$tree" ]; then
  cd "$tree"
fi
