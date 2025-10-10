#!/usr/bin/env bash

# usage: treecp <directory>
# prints the tree of the directory, shows it in terminal,
# and copies it to clipboard (xclip or wl-copy)

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: $TARGET_DIR is not a directory" >&2
  exit 1
fi

DIRNAME=$(basename "$TARGET_DIR")

# Generate the tree
OUTPUT=$(tree -a -I '.git|node_modules|__pycache__' "$TARGET_DIR")

# Add header with the directory name
MESSAGE="mytree $DIRNAME

$OUTPUT
"

# Show it in terminal
echo "$MESSAGE"

# Copy to clipboard
if command -v wl-copy >/dev/null 2>&1; then
  echo "$MESSAGE" | wl-copy
  echo "[copied to clipboard using wl-copy]"
elif command -v xclip >/dev/null 2>&1; then
  echo "$MESSAGE" | xclip -selection clipboard
  echo "[copied to clipboard using xclip]"
else
  echo "Warning: neither wl-copy nor xclip found, clipboard copy skipped" >&2
fi
