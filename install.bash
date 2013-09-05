#!/bin/bash

#NOTE: run this script from the dotfiles directory

ROOT=/root

echo "=======Copying config files======"

#install for current user
cp -R ./bin ~/bin
cp -R ./.vim ~/.vim
cp ./.* ~/.

#install for root
sudo cp -R ./bin "${ROOT}/bin"
sudo cp -R ./.vim "${ROOT}/.vim"
sudo cp -R ./.* "${ROOT}"

echo "=====updating apt and upgrading programs===="
sudo apt-get update && sudo apt-get upgrade

echo "=====installing essential packages====="
sudo apt-get install htop gnome-panel meld build-essential git tmux vim vim-gnome libncurses5-dev python-xlib
