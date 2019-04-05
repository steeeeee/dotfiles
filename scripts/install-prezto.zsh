flag=true

while $flag; do
  prompt "Do you want to install prezto? (y/n) "
  read choice
  case $choice in
    [Yy]* )
        info "Installing prezto...";

        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto";
        
        # setopt EXTENDED_GLOB
        # for rcfile in "${ZDOTDIR:-$HOME}"/dotfiles/prezto/runcoms/^README.md(.N); do
        #   [[ $(basename $rcfile) == "zshrc" || $(basename $rcfile) == "zpreztorc" ]] || (echo -n "  linking $rcfile  " && ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}")
        # done
        info "Base prezto installed, please proceed with shell config file symlinks when asked if you wish to configure it."
        flag=false;
        ;;

    [Nn]* )
          skip "Ok, skipping prezto.";
          flag=false;
          ;;
    * ) echo "Please answer y or n.";;
  esac
done


