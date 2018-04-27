echo "${blue}» Updating ${white}Homebrew and installed packages...${reset}"

# Update Homebrew and current Packages
echo brew update
echo brew upgrade

echo "${blue}» Installing Homebrew ${white}packages...${reset}"

apps=$(cat "$DOTFILES_DIR/homebrew/packages")

# echo < "$DOTFILES_DIR/homebrew/packages"
# echo xargs brew install < "$DOTFILES_DIR/homebrew/packages"
echo brew install "${apps[@]}"

