#!/bin/bash

### Uninstall Shortcuts

# Path to the aliases file
ALIAS_FILE="$(pwd)/aliases.sh"

# Check if aliases are sourced in .bashrc
if grep -q "source $ALIAS_FILE" ~/.bashrc; then
    # Remove the line that sources aliases.sh from .bashrc
    sed -i "/source $ALIAS_FILE/d" ~/.bashrc
    echo "Aliases have been removed from ~/.bashrc"
else
    echo "Aliases were not found in ~/.bashrc"
fi

# Reload .bashrc to apply changes
source ~/.bashrc


### Unistall Shortcuts

# Check if the backup file exists
BACKUP_FILE="$(pwd)/rev_shortcut.sh.backup"
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: No backup of the previous keybinding found!"
    exit 1
fi

# Restore the original keybinding
PREVIOUS_KEYBINDING=$(cat "$BACKUP_FILE")
gsettings set org.gnome.settings-daemon.plugins.media-keys home "$PREVIOUS_KEYBINDING"

# Remove the backup file
rm "$BACKUP_FILE"

echo "Shortcut has been restored to its previous setting."
