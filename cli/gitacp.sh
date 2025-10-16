#!/usr/bin/env bash
set -e

git add .

# Get staged changes (status + filename)
diff_output=$(git diff --cached --name-status)

if [ -z "$diff_output" ]; then
  echo "No staged changes."
  exit 0
fi

# Initialize arrays for each type
added=()
changed=()
deleted=()

# Categorize files
while IFS=$'\t' read -r status file; do
  case "$status" in
  A) added+=("$file") ;;
  M) changed+=("$file") ;;
  D) deleted+=("$file") ;;
  esac
done <<<"$diff_output"

# Build commit message dynamically
commit_message=""

if [ ${#added[@]} -gt 0 ]; then
  commit_message+="added: ${added[*]}"
fi

if [ ${#changed[@]} -gt 0 ]; then
  [ -n "$commit_message" ] && commit_message+="; "
  commit_message+="changed: ${changed[*]}"
fi

if [ ${#deleted[@]} -gt 0 ]; then
  [ -n "$commit_message" ] && commit_message+="; "
  commit_message+="deleted: ${deleted[*]}"
fi

# Commit and push if message is not empty
if [ -n "$commit_message" ]; then
  git commit -m "$commit_message"
  git push
  echo "Committed and pushed with message:"
  echo "$commit_message"
else
  echo "No recognizable changes to commit."
fi
