#!/bin/bash
sudo modprobe brcmsmac
nohup ~/workspace/dotfiles/bin/quicktile/quicktile.py --daemon &
