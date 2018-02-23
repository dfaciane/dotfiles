#!/usr/bin/env zsh

#cd "$(dirname "${BASH_SOURCE}")";

f_install () {
    echo "Installing submodules..."
    git submodule update --init
    echo "Syncing dotfiles to home directory..."
    rsync --exclude ".git/" --exclude ".gitmodules" --exclude ".DS_Store" \
          --exclude "install.sh" --exclude "README.md" --exclude "UNLICENSE" \
          --exclude ".gitignore" --exclude "update.sh" -av --no-perms . ~;
    echo "done"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    f_install;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        f_install;
    fi;
fi;
