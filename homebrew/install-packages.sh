

info "Updating Homebrew and installed packages..."

# Update Homebrew and current Packages
echo brew update
echo brew upgrade

info "Installing Homebrew CLI packages..."

apps=$(cat "$DOTFILES_DIR/homebrew/packages")

# echo < "$DOTFILES_DIR/homebrew/packages"
# echo xargs brew install < "$DOTFILES_DIR/homebrew/packages"
echo brew install "${apps[@]}"

