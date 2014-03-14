# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Add colors 
export TERM=xterm-256color

# oh-my-zsh config
unsetopt correct


# Emacs Aliases
alias e="emacsclient -t" 
alias ec="emacsclient -c"

# System Variables
export EDITOR="emacs"
export JAVA_HOME=$(/usr/libexec/java_home)

# System Aliases
alias sudo='sudo '
alias ltx="latexmk -pdf -pvc" 
alias tlmgr="sudo tlmgr"
alias backup="~/.scripts/backup.sh"
alias julia="~/Source/julia/julia"

alias matlab="/Applications/MATLAB_R2013a.app/bin/matlab -nodisplay"
alias R="$(/usr/bin/which R) --no-save"
alias drake="drip -cp /Users/fnbr/dev/data/drake/target/drake.jar drake.core $@ "
alias clj="lein exec"
alias cm="less /var/mail/fnbr; sudo rm /var/mail/fnbr"

# SSH Aliases:
alias sw="ssh finbarr@dev1.uasuevents.ca"
alias sa="ssh -i ~/.ssh/awsServer.pem ubuntu@ec2-54-200-8-16.us-west-2.compute.amazonaws.com"

# Helpers
#alias grep='grep --color=auto' # Always highlight grep search term
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited

# Start new tmux session if one doesn't already exist 
tmux

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

# Set name of the theme to load.
# Install agnoster theme 
ZSH_THEME="minimal"

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
export PATH=$PATH:/usr/local/opt/php55/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin

# OPAM configuration
. /Users/fnbr/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#export PATH=/usr/local/sbin:/Users/fnbr/.opam/system/bin:/usr/local/Cellar/php55/5.5.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/opt/php55/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/texbin
export PATH=/Users/fnbr/.cabal/bin:$PATH
export PATH=/usr/local/sbin:$PATH
