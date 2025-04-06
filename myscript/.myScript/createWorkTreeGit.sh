#!/bin/bash


# Check if fzy is installed
if ! command -v fzy &> /dev/null; then
  echo "fzy is not installed. Please install it."
  exit 1
fi


WORKINGDIR=$(pwd | sed -E 's/worktree.*//g')
echo "$WORKINGDIR"

# Create worktree directory if it doesn't exist
mkdir -p "$WORKINGDIR"/worktree

# Get the selected branch using fzy
tree=$(git branch | sed -E 's/[+*] //gm' | sed -E 's/\s//gm' | fzy)

# Check if a branch was selected
if [ -z "$tree" ]; then
  echo "No branch selected."
  exit 1
fi

# Create the worktree
if git worktree add "$WORKINGDIR/worktree/$tree" "$tree"; then
  echo "Worktree created for branch: $tree"
else
  echo "Failed to create worktree for branch: $tree"
  exit 1
fi
