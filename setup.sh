#!/bin/sh

scriptPath=$(pwd)
backupsDir=~/"00_dotfiles_backup/$(date +"%Y-%m-%d %H %M")"
doBackup=false

read -p "Do you want to create a backup? (y/n): " choice

if echo "$choice" | grep -iq "^y"; then
    doBackup=true
    mkdir -p "$backupsDir"
    echo "Backup directory created: $backupsDir"
else
    echo "Backup skipped!"
fi

sleep 1

setup()
{
    targetDir=$1
    sourceDir="$scriptPath/$2"
    configuredApp=$3

    if [ -d "$targetDir" ] && $doBackup; then
        mv -f "$targetDir" "$backupsDir/"
    fi

    mkdir -p "$targetDir"
    
    description="# Setting up $configuredApp #"
    border=$(printf '%*s' "${#description}" | tr ' ' '#')

    echo ""
    echo "$border"
    echo "$description"
    echo "$border"

    cd "$sourceDir" || return;

    if [ -f "setup.sh" ]; then
        echo "Executing $configuredApp setup script..."
        sh setup.sh "$targetDir"
        echo "$configuredApp setup script finished."
    fi

    echo "Linking files..."
    
    find . -type f \
         ! -name '*~' \
         ! -name 'setup.sh' \
         ! -name '.DS_Store' \
         ! -name '.gitignore' \
         | while read -r file; do

            dest="$targetDir/${file#./}"
        
            mkdir -p "$(dirname "$dest")"
        
            ln -sf "$(pwd)/$file" "$dest"
          done
    
    echo "Setup complete: $configuredApp"
}


if [ $# -eq 2 ]; then
    targetDir=$1
    sourceDir=$2

    targetDir=$(eval echo "$targetDir")
    sourceDir=$(eval echo "$sourceDir")


    echo "Manual setup!"
    setup "$targetDir" "$sourceDir" "$sourceDir"
    exit 0
fi

setup "$HOME/.emacs.d" "emacs" "Emacs"
setup "$HOME/.config/hypr" "hyprland" "Hyprland"
setup "$HOME/.config/dunst" "dunst" "Dunst"
setup "$HOME/.config/rofi" "rofi" "Rofi"
setup "$HOME/.config/waybar" "waybar" "Waybar"
