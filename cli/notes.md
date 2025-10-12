echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

mkdir -p ~/.local/bin && chmod +x ~/projects/my-arch-linux-setup/cli/setup-ngix.sh && ln -sf ~/projects/my-arch-linux-setup/cli/setup-ngix.sh ~/.local/bin/setup-ngix && echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc


export PATH="$HOME/my-arch-linux-setup/cli:$PATH"


source ~/.bashrc
chmod +x ~/my-arch-linux-setup/cli/*.sh

