#!/bin/bash

### Install Aliases

# Path to the aliases file
ALIAS_FILE="$(pwd)/aliases.sh"

# Check if aliases.sh exists
if [ ! -f "$ALIAS_FILE" ]; then
    echo "Error: aliases.sh file not found!"
    exit 1
fi

# Check if the aliases are already sourced in .bashrc
if ! grep -q "source $ALIAS_FILE" ~/.bashrc; then
    echo "source $ALIAS_FILE" >> ~/.bashrc
    echo "Aliases have been added to ~/.bashrc"
else
    echo "Aliases are already sourced in ~/.bashrc"
fi

# Reload .bashrc to apply changes
source ~/.bashrc


### Install Shortcuts


# Define the path to the shortcuts.sh file
SHORTCUTS_FILE="$(pwd)/shortcuts.sh"

# Check if the shortcuts.sh file exists
if [ ! -f "$SHORTCUTS_FILE" ]; then
    echo "Error: shortcuts.sh file not found!"
    exit 1
fi

# Save the current keybinding before making changes
CURRENT_KEYBINDING=$(gsettings get org.gnome.settings-daemon.plugins.media-keys home)

# Save the current keybinding to a backup file in the current working directory
echo "$CURRENT_KEYBINDING" > "$(pwd)/rev_shortcut.sh.backup"

# Apply the new keybinding from shortcuts.sh
source "$SHORTCUTS_FILE"

echo "Shortcut has been set to Super+e."
