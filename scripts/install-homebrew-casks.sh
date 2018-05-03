
if ! is-macos -o ! is-executable brew; then
  error "Missing dependency: Homebrew"
  return
fi

# Prepare cask
info "Tapping Homebrew repos..."
brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Install packages
info "Installing Homebrew casks..."
xargs brew cask install < $DOTFILES_DIR/homebrew/casks

# Install nerd fonts
info "Installing fonts..."
brew cask install font-hack-nerd-font