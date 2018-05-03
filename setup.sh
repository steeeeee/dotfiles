#!/bin/bash

echo -en "Preparing world domination...\n"

# Include library helpers.
source ./lib/echoes.sh
source ./lib/functions.sh

# Prevent sleep while install is running
caffeinate &





# Ask for the administrator password upfront
step "Get administrator rights upfront"
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Setups messages colors

reset=$'\e[0m'
orange=$'\e[38;5;202m'
white=$'\e[1;37m'
blue=$'\e[38;5;26m'
azure=$'\e[1m\e[34m'


step "This is a test"
info "This is a test"
success "This is a test"
error "This is a test"
warning "This is a test"
skip "This is a test"

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR

# Make utilities available

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$DOTFILES_DIR"

PATH="$DOTFILES_DIR/bin:$PATH"

# Update dotfiles repository itself first

if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

. "$DOTFILES_DIR/scripts/install-homebrew.sh"
. "$DOTFILES_DIR/scripts/install-dotfiles.sh"


# Copy Input Font
step "Copying font files..."
echo "${dot_color_gray_dark}"
cp --verbose -R dotfiles/fonts/*.ttf $HOME/Library/Fonts
echo "${dot_color_reset}"

success "Done. Please open a new shell session"

# iterm2
step "Modifying iterm2 preferences file..."

    # Specify the preferences directory
    list "Setting preferences directory: ${dot_color_gray_dark}$DOTFILES_DIR/iterm2${dot_color_reset}"
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
    # Tell iTerm2 to use the custom preferences in the directory
    list "Enabling preferences external file: ${dot_color_gray_dark}true${dot_color_reset}"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

    success "Done. Please open a new shell session"