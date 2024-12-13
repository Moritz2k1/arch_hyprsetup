#!/bin/bash

echo "Updating System"
wait(3)
sudo pacman -Syu

echo "Installing core packages"
wait(3)
sudo pacman -S git kitty thunar npm nodejs jre-openjdk jdk-openjdk neovim lazygit tmux curl

echo "Installing AUR Helper yay"
wait(3)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -s
cd
rm -rf yay

echo "Installing additional programs"
wait(3)
yay -S firefox ark kvantum nwg-look 


echo "Installing hyprland"
yay -S hyprland
