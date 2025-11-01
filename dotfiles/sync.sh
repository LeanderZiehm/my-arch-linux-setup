#!/usr/bin/env bash
set -e

REPO="$(dirname "$(realpath "$0")")"
TARGETS_FILE="$REPO/sync-targets.txt"
SYNC_DIR="$REPO/files"

# Ensure the sync folder exists
mkdir -p "$SYNC_DIR"
touch "$TARGETS_FILE"

# Use a while loop with a fallback to handle the last line without a newline
while IFS= read -r file || [[ -n "$file" ]]; do
    # Expand ~ to $HOME
    file="${file/#\~/$HOME}"

    if [[ ! -e "$file" ]]; then
        echo "Warning: '$file' does not exist, skipping."
        continue
    fi

    base=$(basename "$file")
    repo_file="$SYNC_DIR/$base"

    # If a file/symlink already exists in the sync folder
    if [[ -e "$repo_file" ]]; then
        if [[ -L "$repo_file" && "$(readlink "$repo_file")" == "$file" ]]; then
            echo "'$repo_file' already symlinks to '$file', skipping."
            continue
        fi

        echo "Conflict: '$repo_file' exists and is not the correct symlink."
        read -p "Overwrite with symlink? (y/n): " yn
        if [[ "$yn" != "y" ]]; then
            echo "Skipped '$repo_file'."
            continue
        fi

        rm -rf "$repo_file"
    fi

    # Create symlink inside sync folder
    ln -s "$file" "$repo_file"
    echo "Symlink created: '$repo_file' -> '$file'"

done < "$TARGETS_FILE"
