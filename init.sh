if [ "$(basename $(pwd))" != ".Files" ]; then
    echo "Please run this script from the .Files directory."
    exit 1
fi

# Install all the base packages we need:
sudo apt-get update && sudo apt-get install git zsh nodejs emacs tmux

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# We don't need the current .zshrc, as it's just the default.
rm ~/.zshrc

ln $(pwd)/{.zshrc,.tmux.conf,.emacs} ~/
ln $(pwd)/minimalist.zsh-theme ~/.oh-my-zsh/themes/
ln -s $(pwd)/emacs.d ~/
