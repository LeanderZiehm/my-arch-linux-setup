if [ -d "$HOME/bin" ]; then
    echo "bin already exists"
else
    echo "bin does not exist"
fi

# Create ~/bin if it doesn't exist
mkdir -p ~/bin
echo "created bin"

# Link your script
ln -sf "$(realpath create-command.sh)" ~/bin/create-command
echo "moved create-command to bin"

# Check if ~/bin is already in .bashrc before adding
if ! grep -q 'export PATH="\$HOME/bin:\$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    echo "added bin to path"
else
    echo "bin already in PATH"
fi

# Reload .bashrc
source "~/.bashrc"
echo "reloaded .bashrc"
