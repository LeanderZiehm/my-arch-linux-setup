#!/usr/bin/env bash
REPO="$(dirname "$(realpath "$0")")"
TARGETS_FILE="$REPO/sync-targets.txt"

if [[ -z "$1" ]]; then
    echo "Usage: $0 <file_or_directory>"
    exit 1
fi

FILE="$1"

# Ensure sync-targets.txt exists
touch "$TARGETS_FILE"

if [[ ! -f "$FILE" && ! -d "$FILE" ]]; then
    echo "File or directory '$FILE' does not exist."
    exit 1
fi

if grep -qxF "$FILE" "$TARGETS_FILE"; then
    echo "'$FILE' is already tracked."
    exit 0
fi

echo "$FILE" >> "$TARGETS_FILE"
echo "Added '$FILE' to sync targets."
