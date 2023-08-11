zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Needed to get zsh working.
FPATH=/home/$USER/.oh-my-zsh/functions:/home/$USER/.oh-my-zsh/completions:/home/$USER/.oh-my-zsh/cache/completions:/home/$USER/.oh-my-zsh/functions:/home/ftimbers_midjournOBey_com/.oh-my-zsh/completions:/home/$USER/.oh-my-zsh/cache/completions:$HOME/share/zsh/5.9/functions
export FPATH

# Disable wandb logging.
export WANDB_SILENT="true"

# Paths
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Improves startup time
skip_global_compinit=1

# Set name of the theme to load.
ZSH_THEME="minimalist"

# Autocomplete settings.
zstyle ':completion:*' users root $USER
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -U compinit && compinit


# load personal settings
# Add colors
export TERM=xterm
export EDITOR="emacsclient"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh


# Force the emacs server to start if not running
export ALTERNATE_EDITOR=""
alias e="emacsclient --tty"

# Increase history size
export HISTFILESIZE=1000
export HISTSIZE=1000

# Make absl fail fast:
export TESTBRIDGE_TEST_RUNNER_FAIL_FAST=1

# get a weird error without this
unset GREP_OPTIONS

# Start new tmux session if one doesn't already exist
if [[ "$TMUX" == "" ]]; then
  tmux new-session $HOME/bin/zsh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/app/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/app/miniconda/etc/profile.d/conda.sh" ]; then
        . "/app/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/app/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="nvm $@"

if [ -f ~/Repos/grind/grind ]; then
    source ~/Repos/grind/grind
    PATH=$HOME/Repos/grind:$PATH
fi
zprof
