#!/bin/bash
cp -r ~/.bashrc ~/dotfiles
cp -r ~/.bash_aliases ~/dotfiles
cd ~/dotfiles
git add --all
git commit
git push
