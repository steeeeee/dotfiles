#!/bin/bash

# Ask for the administrator password upfront

sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Setups messages colors

reset=$'\e[0m'
orange=$'\e[38;5;202m'
white=$'\e[1;37m'
blue=$'\e[38;5;26m'
azure=$'\e[1m\e[34m'

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR

# Make utilities available

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$DOTFILES_DIR"

PATH="$DOTFILES_DIR/bin:$PATH"

# Update dotfiles itself first

if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

. "$DOTFILES_DIR/scripts/install-homebrew.sh"
. "$DOTFILES_DIR/scripts/install-dotfiles.sh"


# iterm2

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
