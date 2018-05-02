echo -e "
${azure}==> In ${white}$PWD ${azure}making symlinks to dotfiles...${reset}"


# Extrapolating dotfiles lists from directories

# Git dotfiles
declare -a gitdots
gitdots+=($(ls -f "$DOTFILES_DIR/git" -I .. -I .))

# Shell dotfiles
declare -a shelldots
shelldots+=($(ls -f "$DOTFILES_DIR/shell" -I .. -I .))

# Files that need to be copied locally dotfiles
declare -a locals
locals+=($(ls -f "$DOTFILES_DIR/local" -I .. -I .))

# zprezto Theme functions
declare -a zpreztothemes
zpreztothemes+=($(ls -f "$DOTFILES_DIR/themes" -I .. -I .))

cd $HOME
echo -e "
${blue}» Moving in ${white}$PWD${reset}"


# Make symlinks to dotfiles
for git in "${gitdots[@]}"
do
  ln -sfv dotfiles/git/$git .$git
done


# Make symlinks to zsh/prezto files
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

# Symlinks zprezto themes
getThemes=true;
while $getThemes; do
  echo
  read -p "${orange}Do you want to symlink prezto themes? y/n: ${reset}" yn
  case $yn in
      [Yy]* )
          for themes in "${zpreztothemes[@]}"
          do
            ln -sfv dotfiles/themes/$theme .zprezto/modules/prompt/functions/$theme
          done
          getThemes=false;
          ;;
      [Nn]* )
        echo "Ok, skipping theme symlinking.";
        getThemes=false;
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
