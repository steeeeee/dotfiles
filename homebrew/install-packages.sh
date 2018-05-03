

info "Updating Homebrew and installed packages..."

# Update Homebrew and current Packages
brew update
brew upgrade

info "Installing Homebrew CLI packages..."

apps=$(cat "$DOTFILES_DIR/homebrew/packages")

# echo < "$DOTFILES_DIR/homebrew/packages"
# echo xargs brew install < "$DOTFILES_DIR/homebrew/packages"
brew install "${apps[@]}"

