echo -e "
${azure}==> In ${white}$PWD ${azure}making symlinks to dotfiles...${reset}"


# Manage the lists better
gitdots=( # gitconfig will copied from local to home
       'gitignore_global'
       'gitattributes'
       );

shelldots=( 'zpreztorc'
        'zprofile'
        'zshenv'
        'zshrc'
        'zlogin'
        'zlogout'
        'dircolors'
      );

locals=('gitconfig'
        );


cd $HOME
echo -e "
${blue}» Moving in ${white}$PWD${reset}"


# Make symlinks to dotfiles
for git in "${gitdots[@]}"
do
  ln -sfv dotfiles/git/$git .$git
done


# Make symlinks to Zsh/Prezto files
getZsh=true;
while $getZsh; do
  echo
  read -p "${orange}Do you want to symlink shell dotfiles? y/n: ${reset}" yn
  case $yn in
      [Yy]* )
          for shell in "${shelldots[@]}"
          do
            ln -sfv dotfiles/shell/$shell .$shell
          done
          getZsh=false;
          ;;
      [Nn]* )
        echo "Ok, skipping shell symlinking.";
        getZsh=false;
        ;;
      * ) echo "Please answer y or n.";;
  esac
done



## Process locals files

# Is .gitconfig overwritten with template version?
gconfOW=false;

for local in "${locals[@]}"
do
  # If local file exists in home it could be customized already or not
  if [ -f .$local ]; then
    echo
    # Make backup of their local file
    echo "${blue}» Saved your current ${white}~/.$local ${blue}to ${white}~/dotfiles/local/$local.bak${reset}"
    cp .$local dotfiles/local/.$local.bak

    echo "${blue}» Now to copy a fresh ${white}$local ${blue}template${reset}"

    getOW=true;
    while $getOW; do
      read -p "${orange}Overwrite your ${white}$PWD/.$local ${blue}? y/n: ${reset}" yn
      case $yn in
          [Yy]* )
              cp -R dotfiles/local/$local ./.${local}
              if [ $local = "gitconfig" ]; then
                gconfOW=true;
              fi
              getOW=false;
              ;;
          [Nn]* )
            echo "Ok, skipping.";
            getOW=false;
            ;;
          * ) echo "Please answer y or n.";;
      esac
    done

  else
    # This local file don't already exist (esp .extra) so copy template over
    cp dotfiles/local/$local ./.${local}
  fi
done
