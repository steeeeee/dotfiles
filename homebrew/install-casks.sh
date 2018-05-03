if ! is-macos -o ! is-executable brew; then
  error "Missing dependency: Homebrew"
  return
fi

# Prepare cask

brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Install packages
info "Installing Homebrew casks..."

apps=$(cat "$DOTFILES_DIR/homebrew/casks")

brew cask install "${apps[@]}"

# xargs brew cask install < ~/.config/brew/brewcasklist


info "Installing fonts..."

brew cask install font-hack-nerd-font