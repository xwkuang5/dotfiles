#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function vim() {
	read -p "Install vim configuration? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Installing vim configuration..."
		# Add .vim to runtime path
		echo "set rtp+=\$HOME/.vim" > $HOME/.vimrc
		echo "source \$HOME/.vim/.vimrc" >> $HOME/.vimrc
		echo "Done..."
	fi;
}

function emacs() {
	read -p "Install emacs configuration? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "Installing emacs configuration..."
		# Chemacs for easy profile change
		git clone https://github.com/plexus/chemacs.git ~/chemacs
		~/chemacs/install.sh

    read -p "Install spacemacs? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Install spacemacs
      git clone https://github.com/syl20bnr/spacemacs ~/spacemacs
      pushd ~/spacemacs && git checkout develop && popd
    fi;

    read -p "Install my own configuration? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      # Install my own configuration
      git clone https://github.com/xwkuang5/emacs.d.git ~/emacs.d
    fi;

		echo "Done..."
		echo "Use emacs --with-profile <profile> to launch emacs (default: default (mine))"
	fi;
}

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "settings.json" \
		--exclude "brew.sh" \
		-avh --no-perms . ~;
	source ~/.bash_profile;

	vim;
	emacs;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
