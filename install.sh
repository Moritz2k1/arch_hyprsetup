#!/bin/bash

# Updating System
echo "Updating System"
sleep 3
sudo pacman -Syu

# Installing core packages if not already installed
echo "Installing needed packages"
sleep 3
sudo pacman -S wget curl zip unzip git zsh
git config --global credential.helper store

# Move dotfiles
mv ~/arch_hyprsetup/dotfiles/.themes ~/
mv ~/arch_hyprsetup/dotfiles/.wallpapers ~/
mv ~/arch_hyprsetup/dotfiles/hypr ~/.config/
mv ~/arch_hyprsetup/dotfiles/icons ~/.local/share/
mv ~/arch_hyprsetup/dotfiles/kitty ~/.config/
mv ~/arch_hyprsetup/dotfiles/.zprofile ~/

# Installing main programs
echo "Installing core programs"
sleep 3
sudo pacman -S neovim firefox kitty thunar thunar-archive-plugin lazygit tmux rclone steam-native-runtime timeshift ark libreoffice-still
git clone https://github.com/Moritz2k1/nvim.git ~/.config/nvim/

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
sleep 3
yay -S visual-studio-code-bin vesktop spotify betterbird quickemu quickgui-bin pokemon-colorscripts-git ttf-go-mono-git

# Installing Hyprland
echo "Installing Hyprland"
sleep 3
sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprcursor hyprutils hyprwayland-scanner xdg-desktop-portal-wlr rofi-wayland
yay -S hyprpolkitagent

# Setting up hyprpanel
#yay -S ags-hyprpanel-git
#sudo pacman -S --needed wireplumber libgtop bluez bluez-utils btop networkmanager dart-sass wl-clipboard brightnessctl swww upower pacman-contrib gvfs
#yay -S --needed aylurs-gtk-shell-git grimblast-git matugen-bin gpu-screen-recorder-git hyprpicker python-gpustat

# Setting up hyprcursor
sudo pacman -S nwg-look
yay -S rose-pine-cursor rose-pine-hyprcursor

# Using EZSH install script for zsh, oh-my-zsh, fzf ...
echo "Installing ZSH + extras"
sleep 3
git clone https://github.com/jotyGill/ezsh
cd ezsh || exit
./install.sh -c
cd || exit
