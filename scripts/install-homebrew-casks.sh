
if ! is-macos -o ! is-executable brew; then
  error "Missing dependency: Homebrew"
  return
fi

# first, a shorthand for an interactive `brew cask install`
# Checks if program is already installed thus
# avoiding to stop the script
get() {
    local p=
    for p; do
        ! brew cask ls $p &>/dev/null || {
            echo "Skipping $p as it's already installed."
            continue
        }
        read -s -n 1 -p "Install or upgrade $p? [y]es, [N]o, or [q]uit: "
        echo $REPLY
        case $REPLY in
            [yY]) brew cask install $p ;;
            [qQ]) exit 0 ;;
            *) # skip
        esac
    done
}

# Prepare cask
info "Tapping Homebrew repos..."
brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Get packages list
IFS=$'\n' read -d '' -r -a casks < "$DOTFILES_DIR/homebrew/casks"

# Install packages
info "Installing Homebrew casks..."

# runs get function for each element in list
for i in "${casks[@]}"
  do
    echo $i
    get $i
done