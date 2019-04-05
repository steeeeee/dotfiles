flag=true

while $flag; do
  prompt "Do you want to install prezto? (y/n) "
  read choice
  case $choice in
    [Yy]* )
        info "Installing prezto. Cloning it from main repository...";
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto";

        info "Setting up zsh as default shell...";
        chsh -s /bin/zsh

        info "Base prezto installed, please proceed with shell config file symlinks when asked if you wish to configure it.";
        flag=false;
        ;;

    [Nn]* )
          skip "Ok, skipping prezto.";
          flag=false;
          ;;
    * ) echo "Please answer y or n.";;
  esac
done


