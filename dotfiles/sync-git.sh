#!/usr/bin/env bash
REPO="$(dirname "$(realpath "$0")")"
cd "$REPO" || exit 1

git_status=$(git status --porcelain)

if [[ -n "$git_status" ]]; then
    echo "Changes ready to commit."
    read -p "Commit and push to origin? (y/n): " yn
    if [[ "$yn" == "y" ]]; then
        git add .
        git commit -m "Sync dotfiles $(date +'%Y-%m-%d %H:%M:%S')"
        git push
        echo "Changes committed and pushed."
    else
        echo "Aborted commit."
    fi
else
    echo "No changes to commit."
fi
