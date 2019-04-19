#!/bin/bash

set -e

rootdir="$HOME/.werkzeug"
dotfilesdir="$rootdir/dotfiles"

# List of dotfiles to work with
dotfiles=(
    .tmux.conf
    .zshrc
)

# Clone werkzeug into your homefolder or update the repository
# if it already exists.
function install_or_update {
    echo "Installing werkzeug ..."
}

# Check if there are existing dotfiles in your home folder
# and back them up if they are not symlinks
function backup_dotfiles {
    echo "Backing up old dotfiles ..."
    for i in "${dotfiles[@]}"
    do
        :
        if [[ -L "$HOME/$i" ]]; then
            echo "$i is a symlink. Skipping."
        else
            echo "$i is not a symlink. Creating a backup at ~/$i.bak"
        fi
    done
}


# Finilizing setup by running post installation setups.
function post_installation {
    echo "Configuring werkzeug ..."
}

install_or_update
backup_dotfiles
post_installation