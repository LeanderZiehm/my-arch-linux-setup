#!/usr/bin/env bash

# Directories
SITES_AVAILABLE="/etc/nginx/sites-available"
SITES_ENABLED="/etc/nginx/sites-enabled"

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "fzf is not installed. Please install it first."
    exit 1
fi

# List enabled sites and let user fuzzy search
selected_site=$(ls -1 "$SITES_ENABLED" | fzf --prompt="Select site to edit: ")

# If user canceled, exit
if [ -z "$selected_site" ]; then
    echo "No site selected. Exiting."
    exit 0
fi

# Open the corresponding sites-available file in Vim
sudo vim "$SITES_AVAILABLE/$selected_site"

