#!/bin/sh

setup()
{
    targetDir=$1

    if [ ! -d "$targetDir" ]; then
        return;
    fi
    
    sourceDir="$(pwd)/$2"
    description="# Setting up $3 #"
    border=$(printf '%*s' "${#description}" | tr ' ' '#')

    echo ""
    echo "$border"
    echo "$description"
    echo "$border"

    cd "$sourceDir" || return;
    
    find . -type f \
         ! -name '*~' \
         ! -name 'setup.sh' \
         ! -name '.DS_Store' \
         ! -name '.gitignore' \
         | while read -r file; do

            dest="$targetDir/${file#./}"
        
            mkdir -p "$(dirname "$dest")"
        
            ln -sfv "$(pwd)/$file" "$dest"
          done
                
    if [ -f "setup.sh" ]; then
        sh setup.sh "$targetDir"
    fi
}

setup "$HOME/.emacs.d" emacs "Emacs"
