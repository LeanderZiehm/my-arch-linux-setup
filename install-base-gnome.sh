\#!/usr/bin/env bash

# install.sh: Automated Arch Linux setup for GNOME

# Usage: curl -fsSL [https://raw.githubusercontent.com/](https://raw.githubusercontent.com/)<username>/arch-setup-install/main/install.sh | sh

set -euo pipefail
IFS=\$'\n\t'

### 1. Update system and install base packages

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm&#x20;
base-devel&#x20;
git&#x20;
wget&#x20;
curl&#x20;
gnome&#x20;
gnome-tweaks&#x20;
vim&#x20;
htop

### 2. Install AUR helper (yay)

cd /tmp
if \[ ! -d yay ]; then
git clone [https://aur.archlinux.org/yay.git](https://aur.archlinux.org/yay.git)
fi
cd yay
git pull --rebase
makepkg -si --noconfirm

### 3. Install additional packages via yay

yay -S --noconfirm&#x20;
google-chrome&#x20;
visual-studio-code-bin&#x20;
spotify&#x20;
flameshot

### 4. Clone personal repositories

mkdir -p "\$HOME/Projects"
cd "\$HOME/Projects"
git clone [https://github.com/](https://github.com/)<username>/dotfiles.git || (cd dotfiles && git pull)

# Add other repos:

# git clone [https://github.com/](https://github.com/)<username>/other-repo.git

### 5. Symlink dotfiles

cd "\$HOME/Projects/dotfiles"
./install.sh  # assume your dotfiles repo has its own installer

### 6. GNOME configuration

# Set favorite apps

gsettings set org.gnome.shell favorite-apps "\['org.gnome.Terminal.desktop', 'firefox.desktop', 'code.desktop']"

# Set keyboard shortcuts example: open terminal with Ctrl+Alt+T

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "\['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

### 7. Set desktop background

gsettings set org.gnome.desktop.background picture-uri "file://\$HOME/Pictures/wallpaper.png"

### 8. Final cleanup

echo "Arch setup complete! Log out and back in to see GNOME changes."
