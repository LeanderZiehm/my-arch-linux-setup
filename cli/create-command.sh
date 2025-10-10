#!/bin/bash

# create-command.sh
# Usage: create-command.sh script.sh
# Makes a global command that always points to the file you specify

set -e

if [ -z "$1" ]; then
  echo "Usage: create-command.sh script.sh"
  exit 1
fi

SCRIPT="$1"

# Resolve absolute path of the script in current dir
ABS_PATH="$(realpath "$SCRIPT")"

if [ ! -f "$ABS_PATH" ]; then
  echo "Error: File '$SCRIPT' does not exist."
  exit 1
fi

chmod +x "$ABS_PATH"

mkdir -p ~/bin

COMMAND_NAME=$(basename "$SCRIPT" .sh)

# Create a symlink in ~/bin pointing to the absolute path
ln -sf "$ABS_PATH" ~/bin/"$COMMAND_NAME"

echo "Global command '$COMMAND_NAME' created!"
echo "You can now run '$COMMAND_NAME' from anywhere, edits are reflected automatically."
