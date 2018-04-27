read -p "
${orange}Do you want to install command line and GUI apps with Homebrew? y/n ${reset}" -r Install_Apps
Install_Apps=${Install_Apps:-n}
if [[ "$Install_Apps" =~ ^(y|Y)$ ]]; 
    then
        # Checks if homebrew is already installed
        echo -e "
        ${azure}==> Installing brew${reset}"
        if [[ $(which brew) == "/usr/local/bin/brew" ]]
            then
                echo "Brew installed already, skipping"
            else
                # Checks if Homebrew can be installed
                if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; 
                    then
                        echo "Can't install Homebrew (missing: ruby, curl and/or git)"
                        return
                    else
                        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                fi
        fi

        # Launch command line packages script

        echo -e "
        ${azure}==> Installing command line apps${reset}"
        source "$DOTFILES_DIR/homebrew/install-packages.sh"

        # Launch GUI apps install scripts
        
        echo -e "
        ${azure}==> Installing GUI apps${reset}"
        source "$DOTFILES_DIR/homebrew/install-casks.sh"

    else
        echo "Ok, skipping Homebrew and packages setup"
fi