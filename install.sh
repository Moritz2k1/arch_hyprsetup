#!/bin/bash

# Updating System
echo "Updating System"
sleep 3
sudo pacman -Syu

# Installing core packages if not already installed
echo "Installing needed packages"
sleep 3
sudo pacman -S wget curl zip unzip git
git config --global credential.helper store

# Installing main programs
echo "Installing core programs"
sleep 3
sudo pacman -S neovim firefox kitty thunar lazygit tmux rclone vesktop steam timeshift ark libreoffice-still
git clone https://github.com/Moritz2k1/nvim.git ~/.config/

# Installing yay
echo "Building yay from source"
sleep 3
git clone https://aur.archlinux.org/yay.git 
cd yay || exit
makepkg -si
cd || exit

# Installing rust, nodejs, npm, java, nasm, pip and gef
echo "Installing programming languages"
sleep 3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo pacman -S nodejs npm jre-openjdk jdk-openjdk nasm python-pip
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# Neovim dependencies
sudo npm install -g neovim
pip install neovim --break-system-packages

# Installing AUR packages
echo "Installing AUR packages"
yay -S visual-studio-code-bin spotify quickemu quickgui-bin

# Installing Hyprland
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprcursor hyprutils hyprwayland-scanner xdg-desktop-portal-wlr rofi-wayland

# Setting up rofi
rm -rf ~/.config/rofi
git clone git@github.com:w8ste/Tokyonight-rofi-theme.git ~/.config/rofi
sudo mv ~/.config/rofi/tokyonight_big1.rasi /usr/share/rofi/themes
rm ~/.config/rofi/README.md

# Using EZSH install script for zsh, oh-my-zsh, fzf ...
git clone https://github.com/jotyGill/ezsh
cd ezsh || exit
./install.sh -c
cd || exit
