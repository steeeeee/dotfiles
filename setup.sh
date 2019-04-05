#!/usr/bin/env bash

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

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR

# Make utilities available
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PATH="$DOTFILES_DIR/bin:$PATH"

# Update dotfiles repository itself first
if is-executable git -a -d "$DOTFILES_DIR/.git"; then 
  info "Updating git repository..."
  git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; 
else 
  warning "Install git in order to update the repository"
fi

. "$DOTFILES_DIR/scripts/install-homebrew.sh"

if hash zsh 2>/dev/null; then
  source "$DOTFILES_DIR/scripts/install-prezto.zsh"
fi

. "$DOTFILES_DIR/scripts/install-dotfiles.sh"


# Copy Input Font
step "Copying font files..."
echo "${dot_color_gray_dark}"
cp -v -R $DOTFILES_DIR/fonts/*.ttf $DOTFILES_DIR/fonts/*.otf $HOME/Library/Fonts
echo "${dot_color_reset}"


# iterm2 Config
step "Modifying iterm2 preferences file..."

# Specify the preferences directory
list "Setting preferences directory: ${dot_color_gray_dark}$DOTFILES_DIR/iterm2${dot_color_reset}"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
list "Enabling preferences external file: ${dot_color_gray_dark}true${dot_color_reset}"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

step "Remove .zcompdump to avoid autocompletion problems..."
rm -fr ~/.zcompdump*

success "Done. Please open a new shell session"

# VSCode Config

# Add Visual Studio Code (code) alias
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

# If alias is available
if type "code" > /dev/null; then
  source "$DOTFILES_DIR/scripts/install-vscode.sh"
else
  error "It looks like the command 'code' isn't accessible."
  error "Please make sure you have Visual Studio Code installed"
  error "And that you executed this procedure: https://code.visualstudio.com/docs/setup/mac"
fi