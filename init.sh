if [ "$(basename $(pwd))" != ".Files" ]; then
    echo "Please run this script from the .Files directory."
    exit 1
fi
ln -s $(pwd)/{.zshrc,.tmux.conf,.emacs,emacs.d} ~/
cp $(pwd)/minimalist.zsh-theme ~/.oh-my-zsh/themes/
