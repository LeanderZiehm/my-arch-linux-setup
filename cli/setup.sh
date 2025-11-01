#!/usr/bin/env bash

# Determine default shell config file based on $SHELL
case "$SHELL" in
    */bash)
        CONFIG_FILE="$HOME/.bashrc"
        ;;
    */zsh)
        CONFIG_FILE="$HOME/.zshrc"
        ;;
    *)
        echo "Unsupported shell. Only bash and zsh are supported."
        exit 1
        ;;
esac

echo "Using config file: $CONFIG_FILE"

# Create ~/bin if it doesn't exist
if [ ! -d "$HOME/bin" ]; then
    mkdir -p "$HOME/bin"
    echo "Created ~/bin"
else
    echo "~/bin already exists"
fi

# Link the script
ln -sf "$(realpath create-command.sh)" "$HOME/bin/create-command"
echo "Linked create-command.sh to ~/bin"

# Add ~/bin to PATH if not already present
if ! grep -Fq 'export PATH="$HOME/bin:$PATH"' "$CONFIG_FILE"; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$CONFIG_FILE"
    echo "Added ~/bin to PATH in $CONFIG_FILE"
else
    echo "~/bin already in PATH"
fi

# Reload config
source "$CONFIG_FILE"
echo "Reloaded $CONFIG_FILE"
