#!/bin/bash
if [ "$(basename $(pwd))" != ".Files" ]; then
    echo "Please run this script from the .Files directory."
    exit 1
fi

# Install all the base packages we need:
sudo apt-get update && sudo apt-get install -y git zsh nodejs emacs tmux elpa-ws-butler

# Install oh-my-zsh
if [[ $SHELL =~ "zsh" ]]; then
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
   
# We don't need the current .zshrc, as it's just the default.
rm ~/.zshrc

for file in ".zshrc" ".tmux.conf" ".emacs"; do
    ln -f $(pwd)/$file ~/
done
ln -f $(pwd)/minimalist.zsh-theme ~/.oh-my-zsh/themes/
ln -sf $(pwd)/emacs.d ~/
