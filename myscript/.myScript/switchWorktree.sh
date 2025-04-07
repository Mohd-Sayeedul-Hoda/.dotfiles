#!/bin/bash

# Check if we're in a Git repository
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
  echo "Not in a Git repository."
  return 1
fi

# Get the list of worktrees and select one with fzy
tree=$(git worktree list | sed -E 's/\s.*//g' | fzy)

# Check if a worktree was selected
if [ -z "$tree" ]; then
  echo "No worktree selected."
  return 1
fi

# Check if the selected worktree exists
if [ ! -d "$tree" ]; then
  echo "Selected worktree does not exist: $tree"
  return 1
fi

# Change directory to the selected worktree
if ! cd "$tree"; then
  echo "Failed to change directory to: $tree"
  return 1
fi
