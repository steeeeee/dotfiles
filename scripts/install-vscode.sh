
step "Installing Visual Studio code extensions and config."

installExt=true;
while $installExt; do

  prompt "Install base vscode extensions? (y/n) "
  read vscode_installresponse
  case vscode_installresponse in
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
  prompt "Do you want to overwrite user config and keybindings? (y/n) "
  read vscode_configresponse
  case vscode_configresponse in
    [Yy]* )
      # Overwriting prefs
      cp $DOTFILES_DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
      cp $DOTFILES_DIR/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

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
