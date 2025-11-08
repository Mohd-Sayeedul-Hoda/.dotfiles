#!/bin/bash

# Check if fzy is installed
if ! command -v fzy &> /dev/null; then
  echo "fzy is not installed. Please install it."
  exit 1
fi

WORKINGDIR=$(pwd | sed -E 's/git_worktrees.*//g')
echo "$WORKINGDIR"

# Create git_worktrees directory if it doesn't exist
mkdir -p "$WORKINGDIR"/git_worktrees

create_worktree() {
  # Get the selected branch using fzy
  tree=$(git branch | sed -E 's/[+*] //gm' | sed -E 's/\s//gm' | fzy)

  # Check if a branch was selected
  if [ -z "$tree" ]; then
    echo "No branch selected."
    return 1
  fi

  # Create the worktree
  if git worktree add "$WORKINGDIR/git_worktrees/$tree" "$tree"; then
    echo "Worktree created for branch: $tree"
  else
    echo "Failed to create worktree for branch: $tree"
    return 1
  fi
}

switch_worktree() {
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
}
