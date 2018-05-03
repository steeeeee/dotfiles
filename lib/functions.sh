
function is_dir_exists(){
  [[ -d "$1" ]] && return 0 || return 1
}

function lnif(){
  if [ -e "$1" ]; then
    info "Linking ${dot_color_light_gray}$1${dot_color_azure} to ${dot_color_light_gray}$2${dot_color_reset}"
    if ( ! is_dir_exists `dirname "$2"` ); then
      mkdir -p `dirname "$2"`
    fi;
    # rm -rf "$2"
    ln -sf "$1" "$2"
  fi;
}

function overwrite_file(){
  getOW=true;
    
  while $getOW; do
    prompt "This will overwrite ${dot_color_light_gray}$1 ${dot_color_purple}with ${dot_color_light_gray}$2${dot_color_purple}. Are you sure? (y/n) "
    read ow_choice
    case $ow_choice in
      [Yy]* )
        info "Overwriting file..."
        cp -R $2 $1
        success "Done."
        getOW=false;
        ;;
      [Nn]* )
        skip "Ok, skipping.";
        getOW=false;
        ;;
      * ) echo "Please answer y or n.";;
    esac
  done
}


function backup_and_copy(){
  # If local file exists in home it could be customized already or not
  if [ -f $HOME/.$1 ]; then
    info "Saving your current ${dot_color_light_gray}.$1 ${dot_color_azure}to ${dot_color_light_gray}~/dotfiles/$2/backup/.$1.backup${dot_color_reset}"
    
    backup_path="$DOTFILES_DIR/$2/backup/.$1"
    if ( ! is_dir_exists `dirname "$backup_path"` ); then
      mkdir -p `dirname "$backup_path"`
    fi;
    cp -v .$1 $backup_path.backup

    success "Successfully saved the current .$1 in $DOTFILES_DIR/$2/backup/"
    info "Now to copy a fresh ${dot_color_light_gray}.$1 ${dot_color_azure}template${dot_color_reset}"

    # Prompts the user to overwrite the file
    overwrite_file $HOME/.$1 $DOTFILES_DIR/$2/$1

  else 
    skip "No existing .$1, proceeding with the copy..."
    info "Copying ${dot_color_light_gray}.$1${dot_color_azure} into ${dot_color_light_gray}$HOME${dot_color_reset}"
    
    # File non existant, proceeds to copy
    cp $DOTFILES_DIR/$2/$1 $HOME/.$1
    
  fi
}
