if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

# brew tap caskroom/versions
# brew tap caskroom/cask
# brew tap caskroom/fonts

# Install packages

echo "${blue}» Installing Homebrew ${white}casks...${reset}"

apps=$(cat "$DOTFILES_DIR/homebrew/casks")

echo "${apps[@]}"
# brew cask install "${apps[@]}"