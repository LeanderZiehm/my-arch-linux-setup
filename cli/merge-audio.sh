#!/usr/bin/env bash
# merge-audio.sh
# Merge all numbered lecture/audio files in the current directory into one file.

set -euo pipefail

OUTFILE="${1:-merged.m4a}"

# Generate file list, sorted naturally
ls -v *.mp3 2>/dev/null | sed "s/^/file '/;s/$/'/" > file_list.txt

if [[ ! -s file_list.txt ]]; then
    echo "❌ No .mp3 files found in this directory."
    exit 1
fi

# Merge without re-encoding (faster, no quality loss)
ffmpeg -hide_banner -loglevel warning -f concat -safe 0 -i file_list.txt -c copy "$OUTFILE"

echo "✅ Merged into: $OUTFILE"
rm -f file_list.txt

