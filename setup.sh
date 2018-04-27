#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Setups messages colors

reset=$'\e[0m'
orange=$'\e[38;5;202m'
white=$'\e[1;37m'
blue=$'\e[38;5;26m'

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR

# Make utilities available

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "$DOTFILES_DIR"

PATH="$DOTFILES_DIR/bin:$PATH"

# Update dotfiles itself first

# if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

. "$DOTFILES_DIR/homebrew/install-packages.sh"




cd $HOME

echo
echo "${blue}» In ${white}$PWD ${blue}making symlinks...${reset}"

dots=( ### .gitconfig will copied from local to home
       '.gitignore_global'
       '.gitattributes'
       '.dircolors'
       );
zshs=('zpreztorc'
      'zprofile'
      'zshenv'
      'zshrc'
      'zlogin'
      'zlogout'
      );
locals=('.gitconfig'
        );


# Make symlinks to dotfiles
for dot in "${dots[@]}"
do
  ln -sfv dotfiles/$dot $dot
done


# Make symlinks to Zsh/Prezto files
getZsh=true;
while $getZsh; do
  echo
  read -p "${orange}Do you want to symlink Zsh dotfiles? y/n: ${reset}" yn
  case $yn in
      [Yy]* )
          for zsh in "${zshs[@]}"
          do
            ln -sfv dotfiles/shell/$zsh .$zsh
          done
          getZsh=false;
          ;;
      [Nn]* )
        echo "Ok, skipping Zsh symlinking.";
        getZsh=false;
        ;;
      * ) echo "Please answer y or n.";;
  esac
done


echo
echo "${blue}» In ${white}$PWD${reset}"

## Process locals files

# Is .gitconfig overwritten with template version?
gconfOW=false;

for local in "${locals[@]}"
do
  # If local file exists in home it could be customized already or not
  if [ -f $local ]; then
    echo
    # Make backup of their local file
    echo "${blue}» Saved your current ${white}~/$local ${blue}to ${white}~/dotfiles/local/$local.bak${reset}"
    cp $local dotfiles/local/$local.bak

    echo "${blue}» Now to copy a fresh ${white}$local ${blue}template${reset}"

    getOW=true;
    while $getOW; do
      read -p "${orange}Overwrite your ${white}$PWD/$local ${blue}? y/n: ${reset}" yn
      case $yn in
          [Yy]* )
              cp -R dotfiles/local/$local .
              if [ $local = ".gitconfig" ]; then
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
    cp dotfiles/local/$local .
  fi
done
