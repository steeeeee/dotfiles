if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

echo "${blue}» Installing ${white}Homebrew...${reset}"
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "${blue}» Updating ${white}Homebrew and installed packages...${reset}"

# brew update
# brew upgrade

echo "${blue}» Installing Homebrew ${white}packages...${reset}"

apps=$(cat "$DOTFILES_DIR/homebrew/packages")

echo "${apps[@]}"
# brew install "${apps[@]}"

