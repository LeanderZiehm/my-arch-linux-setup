#!/bin/bash

# Get all .sh files in the current directory
for file in *.sh; do
    # Skip this script itself to avoid recursion
    if [[ "$file" != "add-all-commands.sh" ]]; then
        echo "Adding command: $file"
        create-command "$file"
    fi
done
