\#!/usr/bin/env bash



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
# obsidian
# gnome-tweaks&#x20;

## setup git
# git config --global user.name "Leander"
# git config --global user.email "leo@leo.com"

# git remote -v
# ssh -T git@mygit.th-deg.de
# git remote set-url origin git@mygit.th-deg.de:ai-project-summer-25/llmano-2.git


### miniconda 
# mkdir -p ~/miniconda3
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
# bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
# rm ~/miniconda3/miniconda.sh

# source ~/miniconda3/bin/activate

### alias 

echo "alias remove-package='sudo pacman -Rsn'" >> ~/.zshrc 
echo "alias conda-activate='source ~/miniconda3/bin/activate'" >> ~/.zshrc 
source ~/.zshrc

### shortcuts
### zsh
# yay zsh 
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
## zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >>~/.zshrc


### 4. Clone personal repositories

# mkdir -p "\$HOME/Projects"
# cd "\$HOME/Projects"
# git clone [https://github.com/](https://github.com/)<username>/dotfiles.git || (cd dotfiles && git pull)

# Add other repos:

# git clone [https://github.com/](https://github.com/)<username>/other-repo.git

### 5. Symlink dotfiles

# cd "\$HOME/Projects/dotfiles"
# ./install.sh  # assume your dotfiles repo has its own installer

### 6. GNOME configuration

# Set favorite apps

# gsettings set org.gnome.shell favorite-apps "\['org.gnome.Terminal.desktop', 'firefox.desktop', 'code.desktop']"

# Set keyboard shortcuts example: open terminal with Ctrl+Alt+T
#
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "\['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'

# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'

# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary><Alt>t'

### 7. Set desktop background

gsettings set org.gnome.desktop.background picture-uri "https://drive.google.com/file/d/1DADrXXzxugbyE30mQJhFUTvi-8LAmUyy/view?usp=sharing"
