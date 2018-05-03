if ! is-macos -o ! is-executable brew; then
  error "Missing dependency: Homebrew"
  return
fi

# Prepare cask

echo brew tap caskroom/versions
echo brew tap caskroom/cask
echo brew tap caskroom/fonts

# Install packages
info "Installing Homebrew casks..."

apps=$(cat "$DOTFILES_DIR/homebrew/casks")

echo brew cask install "${apps[@]}"

# xargs brew cask install < ~/.config/brew/brewcasklist


info "Installing fonts..."

echo brew cask install font-hack-nerd-font