#!/bin/bash

if ! command -v pacman >/dev/null 2>&1; then 
  printf "\e[31m[$0]: pacman not found, it seems that the system is not ArchLinux or Arch-based distros. Aborting...\e[0m\n"
  exit 1
fi

if ! command -v yay >/dev/null 2>&1; then 
  printf "\e[31m[%s]: yay not found, make sure it is installed. Aborting...\e[0m\n" "$0"
  exit 1
fi

echo "Beware, lots of confirmation incoming!"

yay -S $(cat <<EOF
git
grep
ripgrep
fd
hyprland
uwsm
nerd-fonts
gcr
remmina
emacs
alacritty
nautilus
nautilus-admin-gtk4
nautilus-image-converter
nautilus-open-any-terminal
dunst
pipewire
wireplumber
xdg-desktop-portal-hyprland-git
hyprland-qt-support
hyprpolkitagent
qt5-wayland
qt6-wayland
qt6ct
waybar
rofi-wayland
cliphist
udiskie
hypridle
hyprlock
network-manager-applet
blueman
htop
gnome-keyring
hyprshot
hyprpaper
code
EOF
)

TARGET_BASHRC="$HOME/.bashrc"

CODE_BLOCK='if [ "$(tty)" == "/dev/tty1" ]; then
    if uwsm check may-start; then
        exec uwsm start hyprland.desktop
    fi
fi'

if ! grep -Fxq "$CODE_BLOCK" "$TARGET_BASHRC"; then
    echo "Updating $TARGET_BASHRC to execute Hyprland when logged to tty1"
    echo -e "\n$CODE_BLOCK" >> "$TARGET_BASHRC"
    echo "$TARGET_BASHRC updated"
fi
