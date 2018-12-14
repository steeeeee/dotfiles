flag=true

while $flag; do
  prompt "Do you want to install prezto? (y/n) "
  read choice
  case $choice in
    [Yy]* )
        info "Installing prezto..."

        setopt EXTENDED_GLOB
        for rcfile in "${ZDOTDIR:-$HOME}"/dotfiles/prezto/runcoms/^README.md(.N); do
          [[ $(basename $rcfile) == "zshrc" || $(basename $rcfile) == "zpreztorc" ]] || (echo -n "  linking $rcfile  " && ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}")
        done

    [Nn]* )
          skip "Ok, skipping prezto.";
          flag=false;
          ;;
    * ) echo "Please answer y or n.";;
  esac
done


