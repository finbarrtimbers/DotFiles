# Add colors
export TERM=xterm-256color
export EDITOR="mg"

# Use the "Z" script:
. /usr/local/Cellar/z/1.8/etc/profile.d/z.sh

# Increase history size
export HISTFILESIZE=1000
export HISTSIZE=1000

# Hadoop settings
export JAVA_HOME="$(/usr/libexec/java_home)"
export HADOOP_CLASSPATH=$JAVA_HOME/lib/tools.jar
export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.realm= -Djava.security.krb5.kdc="
export HADOOP_OPTS="${HADOOP_OPTS} -Djava.security.krb5.conf=/dev/null"

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

# Start emacs daemon if it's not already running
export ALTERNATE_EDITOR=""

# get a weird error without this
unset GREP_OPTIONS
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# System Aliases
alias e="emacsclient -t"
alias diffpdf="diff-pdf"
alias ltx="latexmk -pdf -pvc"
alias xltx="latexmk -pdf -pvc -e '\$pdflatex=q/xelatex %O %S/'"
alias tlmgr="sudo tlmgr"
alias sudo='sudo '
alias R="/usr/local/bin/R --no-save"
alias julia="/Applications/Julia-0.3.0.app/Contents/Resources/julia/bin/julia"
alias ijulia="ipython notebook --profile julia"
alias w="networksetup -setairportpower en0"

# vagrant aliases
alias vs="vagrant ssh"
alias sd="ssh ft@178.62.57.234"
alias swrp="ssh wmembers@members.wildrose.ca"
# OPAM configuration
. /Users/ft/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
