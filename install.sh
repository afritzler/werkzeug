#!/bin/bash

set -e

rootdir="$HOME/.werkzeug"
dotfilesdir="$rootdir/dotfiles"
repo="https://github.com/afritzler/werkzeug"
install_dir="$HOME/.werkzeug"
dotfile_dir="$install_dir/dotfiles"

# List of dotfiles to work with
dotfiles=(
    .tmux.conf
    .zshrc
)

# Clone werkzeug into your homefolder or update the repository
# if it already exists.
function install_or_update {
    echo "Installing werkzeug ..."
    if [ ! -d $install_dir ]; then
        echo "Installing werkzeug under $install_dir ..."
        git clone $repo $install_dir
    else
        echo "Updating existing version ..."
        (
            cd $install_dir
            git pull origin master
        )
    fi
}

# Check if there are existing dotfiles in your home folder
# and back them up if they are not symlinks
function backup_dotfiles {
    echo "Backing up old dotfiles ..."
    for i in "${dotfiles[@]}"
    do
        :
        # Check if file is either a symlink or does not exist
        if [ ! -f "$HOME/$i" ]; then
            echo "$i file not found. Skipping backup."
        elif [ -L "$HOME/$i" ] 
        then
            echo "$i is a symlink. Skipping backup."
        else
            echo "$i is not a symlink. Creating a backup at ~/$i.bak"
            mv "$HOME/$i" "$HOME/$i.bak"
        fi
    done
}

# Finilizing setup by running post installation setups.
function post_installation {
    echo "Configuring werkzeug ..."
    for i in "${dotfiles[@]}"
    do
        :
        # Create symlinks
        if [ ! -f "$HOME/$i" ]; then
            echo "Creating symlink $i -> $dotfile_dir/$i"
            ln -s "$dotfile_dir/$i" "$HOME/$i"
        elif [ -L "$HOME/$i" ]
        then
            echo "Updating symlink $i -> $dotfile_dir/$i"
            rm "$HOME/$i"
            ln -s "$dotfile_dir/$i" "$HOME/$i"
        else
            # This should never happened!
            echo "$i is still present and is not a symlink. This should not have happened!"
        fi
    done
}

install_or_update
backup_dotfiles
post_installation