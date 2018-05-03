
info "Updating Homebrew and installed packages..."

# Update Homebrew and current Packages
brew update
brew upgrade

# Install CLI packages
info "Installing Homebrew CLI packages..."
xargs brew install < "$DOTFILES_DIR/homebrew/packages"

