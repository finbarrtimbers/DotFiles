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

autoload -U zmv
autoload -U compinit && compinit

# Autocomplete settings.
zstyle ':completion:*' users root $USER
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Speeds up Git autocomplete.
__git_files () {
    _wanted files expl 'local files' _files
}

# load personal settings
# Add colors
export TERM=xterm-256color
export EDITOR="mg"

# Use the "Z" script:
. ~/Repos/.Files/z.sh

# Increase history size
export HISTFILESIZE=1000
export HISTSIZE=1000

# start tmux if not running
if [ "$TMUX" = "" ];
then tmux;
fi

# Paths
export PATH=/usr/local/opt/ruby/bin:$PATH
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export PATH=$PATH:/usr/local/opt/php55/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export GOPATH=/usr/local/go/
export PATH=$JAVA_HOME/bin:$PATH

# get a weird error without this
unset GREP_OPTIONS
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# System Aliases
alias e="emacsclient -t"
alias ltx="latexmk -pdf -pvc"
alias xltx="latexmk -pdf -pvc -e '\$pdflatex=q/xelatex %O %S/'"
alias sudo='sudo '
