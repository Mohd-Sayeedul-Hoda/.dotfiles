#!/bin/bash

# Git Worktree Manager with Tmux Integration
# Usage: ./worktree_manager.sh create
#        ./worktree_manager.sh switch
#        ./worktree_manager.sh list

CENTRAL_WORKTREE_DIR="$HOME/git_worktrees"

# Ensure fzf is installed
if ! command -v fzf &> /dev/null; then
  echo "fzf is not installed. Please install it for better fuzzy finding."
  echo "Falling back to fzy..."
  if ! command -v fzy &> /dev/null; then
    echo "fzy is also not installed. Please install fzf or fzy."
    exit 1
  fi
  FUZZY_FINDER="fzy"
else
  FUZZY_FINDER="fzf"
fi

# Function to get repo name
get_repo_name() {
  repo_path=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Not in a Git repository."
    exit 1
  fi
  basename "$repo_path"
}

# Function to create worktree
create_worktree() {
  repo_name=$(get_repo_name)
  mkdir -p "$CENTRAL_WORKTREE_DIR/$repo_name"

  # List branches
  branches=$(git branch --all | sed 's/*//;s/ //g' | grep -v '^remotes/')

  if [ "$FUZZY_FINDER" = "fzf" ]; then
    selected_branch=$(echo "$branches" | fzf --prompt="Select branch for worktree: ")
  else
    selected_branch=$(echo "$branches" | fzy)
  fi

  if [ -z "$selected_branch" ]; then
    echo "No branch selected."
    exit 1
  fi

  worktree_path="$CENTRAL_WORKTREE_DIR/$repo_name/$selected_branch"

  if git worktree add "$worktree_path" "$selected_branch"; then
    echo "Worktree created: $worktree_path"

    # Create tmux session for this worktree
    if command -v tmux &> /dev/null; then
      session_name="${repo_name}_${selected_branch//[^a-zA-Z0-9]/_}"
      tmux new-session -d -s "$session_name" -c "$worktree_path"
      echo "Tmux session created: $session_name"
      echo "Attach with: tmux attach -t $session_name"
    fi
  else
    echo "Failed to create worktree for branch: $selected_branch"
    exit 1
  fi
}

# Function to switch worktree (attach to tmux session)
switch_worktree() {
  # List all worktrees from central directory
  worktrees=$(find "$CENTRAL_WORKTREE_DIR" -mindepth 2 -maxdepth 2 -type d)

  if [ "$FUZZY_FINDER" = "fzf" ]; then
    selected_worktree=$(echo "$worktrees" | fzf --prompt="Select worktree to switch to: ")
  else
    selected_worktree=$(echo "$worktrees" | fzy)
  fi

  if [ -z "$selected_worktree" ]; then
    echo "No worktree selected."
    exit 1
  fi

  repo_name=$(basename "$(dirname "$selected_worktree")")
  branch_name=$(basename "$selected_worktree")

  # Try to attach to tmux session
  if command -v tmux &> /dev/null; then
    session_name="${repo_name}_${branch_name//[^a-zA-Z0-9]/_}"
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux attach -t "$session_name"
    else
      echo "Tmux session '$session_name' not found. Creating new one..."
      tmux new-session -s "$session_name" -c "$selected_worktree"
    fi
  else
    cd "$selected_worktree" || exit 1
    echo "Changed to worktree: $selected_worktree"
  fi
}

# Function to remove worktree
remove_worktree() {
  # List all worktrees from central directory
  worktrees=$(find "$CENTRAL_WORKTREE_DIR" -mindepth 2 -maxdepth 2 -type d)

  if [ "$FUZZY_FINDER" = "fzf" ]; then
    selected_worktree=$(echo "$worktrees" | fzf --prompt="Select worktree to remove: ")
  else
    selected_worktree=$(echo "$worktrees" | fzy)
  fi

  if [ -z "$selected_worktree" ]; then
    echo "No worktree selected."
    exit 1
  fi

  repo_name=$(basename "$(dirname "$selected_worktree")")
  branch_name=$(basename "$selected_worktree")

  echo "Removing worktree: $selected_worktree"
  if git worktree remove "$selected_worktree"; then
    echo "Worktree removed successfully."

    # Kill tmux session if it exists
    if command -v tmux &> /dev/null; then
      session_name="${repo_name}_${branch_name//[^a-zA-Z0-9]/_}"
      if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux kill-session -t "$session_name"
        echo "Tmux session '$session_name' killed."
      fi
    fi
  else
    echo "Failed to remove worktree."
    exit 1
  fi
}

# Function to list worktrees
list_worktrees() {
  echo "Git worktrees in $CENTRAL_WORKTREE_DIR:"
  find "$CENTRAL_WORKTREE_DIR" -mindepth 2 -maxdepth 2 -type d | while read -r worktree; do
    repo=$(basename "$(dirname "$worktree")")
    branch=$(basename "$worktree")
    echo "$repo/$branch: $worktree"
  done
}

# Main script logic
case "$1" in
  create)
    create_worktree
    ;;
  switch)
    switch_worktree
    ;;
  remove)
    remove_worktree
    ;;
  list)
    list_worktrees
    ;;
  *)
    echo "Usage: $0 {create|switch|remove|list}"
    exit 1
    ;;
esac
