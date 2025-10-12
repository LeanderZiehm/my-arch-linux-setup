#!/bin/bash

# Default length
LENGTH=${1:-32}

# Charset definitions
LOWER="abcdefghijklmnopqrstuvwxyz"
UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUM="0123456789"
SPECIAL="!@#%^&*()-_=+[]{}<>?,."

# Ensure at least one of each type
PASS=$(
  # pick one of each first
  echo -n "${LOWER:RANDOM%${#LOWER}:1}"
  echo -n "${UPPER:RANDOM%${#UPPER}:1}"
  echo -n "${NUM:RANDOM%${#NUM}:1}"
  echo -n "${SPECIAL:RANDOM%${#SPECIAL}:1}"

  # fill the rest
  for ((i = 4; i < LENGTH; i++)); do
    ALL="$LOWER$UPPER$NUM$SPECIAL"
    echo -n "${ALL:RANDOM%${#ALL}:1}"
  done
)

# Shuffle the result
PASS=$(echo "$PASS" | fold -w1 | shuf | tr -d '\n')

# Output
echo "Generated password: $PASS"

# Copy to clipboard automatically
if command -v xclip &>/dev/null; then
  echo -n "$PASS" | xclip -selection clipboard
  echo "(Copied to clipboard via xclip)"
elif command -v wl-copy &>/dev/null; then
  echo -n "$PASS" | wl-copy
  echo "(Copied to clipboard via wl-copy)"
else
  echo "(No clipboard tool found, install xclip or wl-copy to auto-copy)"
fi
