#!/bin/sh

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
alacritty
dolphin
dolphin-plugins
kservice5
kdbusaddons5
kfilemetadata5
kconfig5
kcoreaddons5
kcrash5
kguiaddons5
ki18n5
kitemviews5
kwidgetsaddons5
kwindowsystem5
kservice5
dunst
pipewire
wireplumber
xdg-desktop-portal-hyprland-git
hyprland-qt-support
hyprpolkitagent
qt5-wayland
qt6-wayland
waybar
rofi-wayland
cliphist
udiskie
hypridle
hyprlock
easyeffects
network-manager-applet
blueman
EOF
)

