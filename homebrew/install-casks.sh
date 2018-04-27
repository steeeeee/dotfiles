if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

# Prepare cask

echo brew tap caskroom/versions
echo brew tap caskroom/cask
echo brew tap caskroom/fonts

# Install packages

echo "
${blue}» Installing ${white}Homebrew casks...${reset}"

apps=$(cat "$DOTFILES_DIR/homebrew/casks")

echo brew cask install "${apps[@]}"

# xargs brew cask install < ~/.config/brew/brewcasklist

echo "
${blue}» Installing ${white}fonts...${reset}"

echo brew cask install font-hack-nerd-font