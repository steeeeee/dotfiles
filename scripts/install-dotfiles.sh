step "Starting dotfiles configuration..."

# Sets up directories to read
symlinks=( 'shell'
           'themes'
           'git'
           'locals' );

for dir in "${symlinks[@]}"
  do 
    flag=true

    # Empties file array
    declare -a dots=()

    # Extrapolating dotfiles lists from directories
    dots+=($(ls -Ff "$DOTFILES_DIR/$dir" | grep -v '[/@=|]$' | tr -d \*))
    
    while $flag; do
      prompt "Do you want to manage $dir dotfiles? (y/n) "
      read choice
      case $choice in
        [Yy]* )
          for dot in "${dots[@]}"
            do
            
              if [ "$dir" = "themes" ]; then
                # Symlink prezto themes
                lnif "$DOTFILES_DIR/$dir/$dot" \
                     "$HOME/.zprezto/modules/prompt/functions/$dot"
                
              elif [ "$dir" = "locals" ]; then
                # Backup local files if existant and 
                # copy/overwrite the template
                backup_and_copy $dot $dir
               
              else 
                # Symlink files
                lnif "$DOTFILES_DIR/$dir/$dot" \
                     "$HOME/.$dot"
              fi

          done
          flag=false;
          ;;
        [Nn]* )
          skip "Ok, skipping $dir.";
          flag=false;
          ;;
        * ) echo "Please answer y or n.";;
      esac
    done
done

