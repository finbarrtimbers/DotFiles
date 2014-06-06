# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Add colors 
export TERM=xterm-256color

# oh-my-zsh config
unsetopt correct

export EDITOR="mg"

# Emacs Aliases
alias e="emacsclient -t" 
alias ec="emacsclient -c"

# System Variables
alias sudo='sudo '
export JAVA_HOME=$(/usr/libexec/java_home)

# System Aliases
alias sudo='sudo '
alias ltx="latexmk -pdf -pvc" 
alias xltx="latexmk -pdf -pvc -e '\$pdflatex=q/xelatex %O %S/'" 
alias tlmgr="sudo tlmgr"
alias backup="~/.scripts/backup.sh"
alias profile="~/.scripts/profile.sh"
alias julia="~/Source/julia/julia"
alias grep="ggrep"

# alias R="$(/usr/bin/which R) --no-save"

# Start new tmux session if one doesn't already exist 
if [[ "$TMUX" == "" ]]; then
    tmux new-session 
fi

# Handy functions 
killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}


# Paths
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

# Use the "Z" script: 
. `brew --prefix`/Cellar/z/1.8/etc/profile.d/z.sh

# Add ruby gems to the path 
export PATH=`brew --prefix ruby`/bin:$PATH

# Add Android SDK to the path
export ANDROID_HOME=/usr/local/opt/android-sdk

# Add autocomplete for teamocil 
compctl -g '~/.teamocil/*(:t:r)' teamocil


export HISTFILESIZE=10000
export HISTSIZE=10000
export WEKA_JAR_PATH=/usr/share/java/weka.jar
# Set name of the theme to load.
# Install agnoster theme 
ZSH_THEME="minimalist"

# Use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/opt/php55/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin
export PATH=/usr/local/sbin:/usr/local/bin:$PATH


# OPAM configuration
. /Users/fnbr/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#export PATH=/usr/local/sbin:/Users/fnbr/.opam/system/bin:/usr/local/Cellar/php55/5.5.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/opt/php55/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin
export PATH=/Users/fnbr/.cabal/bin:$PATH
archey --color
