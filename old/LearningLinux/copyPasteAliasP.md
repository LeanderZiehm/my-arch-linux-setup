# 1. Create a ~/bin directory if it doesn't exist
mkdir -p ~/bin

# 2. Create the script file
cat > ~/bin/p <<'EOF'
#!/usr/bin/env bash
if [ $# -ne 1 ]; then
  echo "Usage: p <filename>" >&2
  exit 1
fi
xclip -o > "$1"
EOF

# 3. Make it executable
chmod +x ~/bin/p

# 4. Add ~/bin to your PATH if it’s not already there
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
  source ~/.bashrc
fi