
# Make symlinks to zsh/prezto files
installApps=true;
while $installApps; do
    prompt "Do you want to install command line and GUI apps with Homebrew? (y/n) "
    read install
    case $install in
        [Yy]* )
            step "Installing Homebrew..."
            if [[ $(which brew) == "/usr/local/bin/brew" ]]
                then
                    skip "Brew installed already, skipping"
                else
                    # Checks if Homebrew can be installed
                    if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; 
                        then
                            error "Can't install Homebrew (missing: ruby, curl and/or git)"
                            return
                        else
                            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                    fi
            fi

            # Launch command line packages script

            step "Installing command line apps with Homebrew..."
            source "$DOTFILES_DIR/scripts/install-homebrew-packages.sh"

            # Launch GUI apps install scripts
            
            step "Installing GUI apps with Homebrew..."
            source "$DOTFILES_DIR/scripts/install-homebrew-casks.sh"
            
            installApps=false;
            ;;

        [Nn]* )
            skip "Ok, skipping Homebrew and packages setup";
            installApps=false;
            ;;

        * ) echo "Please answer y or n.";;
  esac
done