
step "Installing Visual Studio code extensions and config."

installExt=true;
while $installExt; do

  prompt "Install base vscode extensions? (y/n) "
  read vscode_installresponse
  case $vscode_installresponse in
    [Yy]* )
      info "Installing extensions please wait..."
      
      code --install-extension EditorConfig.EditorConfig
      code --install-extension dbaeumer.vscode-eslint
      code --install-extension kisstkondoros.vscode-gutter-preview
      code --install-extension christian-kohler.npm-intellisense
      code --install-extension christian-kohler.path-intellisense
      code --install-extension mrmlnc.vscode-scss
      code --install-extension cssho.vscode-svgviewer
      code --install-extension cssho.vscode-svgviewer
      code --install-extension wayou.vscode-todo-highlight
      code --install-extension emmanuelbeziat.vscode-great-icons
      code --install-extension humao.rest-client
      
      success "Extensions for VSC have been installed. Please restart your VSC."
      installExt=false;
      ;;
    [Nn]* )
      skip "Ok, skipping extensions."
      installExt=false;
      ;;
    * ) echo "Please answer y or n";;
  esac
done


while $installConfig; do
  prompt "Do you want to symlink user config and keybindings? (y/n) "
  read vscode_configresponse
  case $vscode_configresponse in
    [Yy]* )
      
      vscode_config_dir="$HOME/Library/Application Support/Code/User"
      
      # Create user dir if it doesn't exist
      if ( ! is_dir_exists $vscode_config_dir ); then
        warning "User dir not existing"
        info "Creating Visual Studio Code User directory"
        mkdir -pv "$vscode_config_dir"
      fi;

      # Symlink config files
      lnif "$DOTFILES_DIR/vscode/settings.json" \
           "$vscode_config_dir/settings.json"

      lnif "$DOTFILES_DIR/vscode/keybindings.json" \
           "$vscode_config_dir/keybindings.json"
            
      # cp $DOTFILES_DIR/vscode/settings.json $vscode_config_dir/settings.json
      # cp $DOTFILES_DIR/vscode/keybindings.json $vscode_config_dir/keybindings.json

      success "New user config has been written. Please restart your VSC."

      installConfig=false;
      ;;
    [Nn]* )
      skip "Skipping user config overwriting.";
      installConfig=false;
      ;;
    * ) echo "Please answer y or n";;
  esac
done
