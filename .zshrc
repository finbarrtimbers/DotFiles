# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Improves startup time
skip_global_compinit=1
# Set name of the theme to load.
ZSH_THEME="minimalist"
source $ZSH/oh-my-zsh.sh
# Start new tmux session if one doesn't already exist
if [[ "$TMUX" == "" ]]; then
   tmux new-session
fi
# zsh-plugins
plugins=( zsh-syntax-highlighting)

# load personal settings
source ~/.profile
