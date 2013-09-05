#!/bin/bash
sudo modprobe brcmsmac
nohup ~/workspace/dotfiles/bin/quicktile/quicktile.py --daemon &
nohup metacity --replace &
sleep 10
nohup gnome-panel &
