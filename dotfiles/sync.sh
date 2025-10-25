#!/usr/bin/env bash
REPO="$(dirname "$(realpath "$0")")"
TARGETS_FILE="$REPO/sync-targets.txt"

touch "$TARGETS_FILE"

while IFS= read -r file; do
    if [[ ! -e "$file" ]]; then
        echo "Warning: '$file' does not exist, skipping."
        continue
    fi

    base=$(basename "$file")
    repo_file="$REPO/$base"

    if [[ -e "$repo_file" ]]; then
        if ! cmp -s "$file" "$repo_file"; then
            echo "Changes detected in '$file'"
            read -p "Copy changes to repo? (y/n): " yn
            if [[ "$yn" == "y" ]]; then
                cp -r "$file" "$repo_file"
                echo "'$file' updated in repo."
            fi
        fi
    else
        cp -r "$file" "$repo_file"
        echo "New file '$file' added to repo."
    fi
done < "$TARGETS_FILE"
