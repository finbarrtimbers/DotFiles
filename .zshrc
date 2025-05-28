# Basic environment setup
export PATH=$HOME/bin:/usr/local/bin:~/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export TZ='America/Edmonton'
export TERM=xterm
export EDITOR="emacs"
export ALTERNATE_EDITOR=""
export WANDB_SILENT="true"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
export HISTFILESIZE=1000
export HISTSIZE=1000
export TESTBRIDGE_TEST_RUNNER_FAIL_FAST=1

# ~/.zshrc  (or ~/.bash_profile, etc.)
export LANG=en_CA.UTF-8
export LC_CTYPE=$LANG

# Oh-My-Zsh settings
DISABLE_AUTO_TITLE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"
ZSH_THEME="minimalist"

# Completion setup
skip_global_compinit=1
FPATH="$ZSH/functions:$ZSH/completions:$HOME/.oh-my-zsh/completions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:$FPATH"
zstyle ':completion:*' users root $USER
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias e="emacsclient --tty"
unset GREP_OPTIONS

# Tmux check (only in interactive shells)
if [[ $- == *i* ]] && [[ -z "$TMUX" ]]; then
  tmux new-session
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/finbarrtimbers/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/finbarrtimbers/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/finbarrtimbers/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/finbarrtimbers/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
