# Basic environment setup
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
export GOPATH=$HOME/go

# ~/.zshrc  (or ~/.bash_profile, etc.)
export LANG=en_US.UTF-8
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
compinit -C

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias e="emacsclient --tty"
unset GREP_OPTIONS

# --- detect whether we're inside VS Code / Cursor ----------------------------
# Any env-var that starts with "VSCODE_" means we're in the integrated terminal
if env | grep -q '^VSCODE_'; then
  export IS_VSCODE=true
else
  export IS_VSCODE=false
fi

# Always prioritize /usr/local/bin over /usr/bin
export PATH=/usr/local/bin:$HOME/.local/bin:$PATH

# If we're not in VSCode, add additional paths:
if [[ $IS_VSCODE == false ]]; then
 	export PATH=$HOME/bin:~/.local/bin:$GOPATH/bin:$PATH
fi

# --- auto-tmux only when it makes sense -------------------------------------
#  * interactive shell (`$-` contains i)
#  * not already inside tmux
#  * tmux is installed
#  * **NOT** running under VS Code / Cursor
if [[ $- == *i* ]] && [[ -z $TMUX ]] && [[ $IS_VSCODE == false ]] \
   && command -v tmux >/dev/null; then
  # Create a new session each time (don't use -A flag)
  tmux new-session
fi

function beaker_logs() {
    local experiment_id=$1
    local job_id=$(beaker experiment inspect $experiment_id --format=json | jq -r '.[0].jobs[0].id')
    beaker job logs $job_id
}

# Commit + push in one step
gp() {
  local msg="$*"          # all arguments as one string, preserving spaces
  if [[ -z $msg ]]; then
    echo "Usage: gp <commit-message>"
    return 1
  fi
  git commit -am "$msg" && git push
}

pp() {
    git pull && git push
}

if [[ -n "$VIRTUAL_ENV" ]]; then
    export PATH="$VIRTUAL_ENV/bin:$PATH"
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/finbarrtimbers/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/finbarrtimbers/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/finbarrtimbers/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/finbarrtimbers/google-cloud-sdk/completion.zsh.inc'; fi

# opencode
export PATH=/Users/finbarrtimbers/.opencode/bin:$PATH

# AI2 credentials
if [ -f "$HOME/ai2-creds.sh" ]; then
    . "$HOME/ai2-creds.sh"
elif [ -f "$HOME/.ai2-creds" ]; then
    . "$HOME/.ai2-creds"
fi
# beaker-session
#
# Usage:
#   beaker-session [OPTIONS]
#
# Options:
#   -h, --help
#       Print this help message and exit.
#
#   -c CLUSTER, --cluster CLUSTER, --cluster=CLUSTER
#       Beaker cluster to use. Defaults to:
#         ai2/hammond
#
#   -f, --force
#       Force creation of a new session even if one already exists.
#
# Description:
#   - Determines your Beaker username via `beaker account whoami`.
#   - Reuses an existing Beaker session on the target cluster if one exists.
#   - Otherwise creates a new detached remote bare session with:
#       * multiple weka mounts
#       * secret mounts
#       * workdir /root
#       * workspace ai2/open-instruct-dev
#       * budget ai2/allennlp
#       * --save-image
#   - Resolves BEAKER_NODE_HOSTNAME for the session.
#   - Uses mosh to connect to the node and attaches to the session.
#
# Requirements:
#   - beaker CLI
#   - jq
#   - mosh (mosh-server must be present on the node)

beaker-session() {
  # Defaults
  local cluster="ai2/hammond"
  local force=0

  # Parse flags
  while (( $# > 0 )); do
    case "$1" in
      -h|--help)
        echo "beaker-session [-h|--help] [-f|--force] [-c|--cluster CLUSTER|--cluster=CLUSTER]"
        return 0
        ;;
      -f|--force)
        force=1
        shift
        ;;
      -c|--cluster)
        [[ $# -ge 2 ]] || { echo "Error: --cluster requires an argument" >&2; return 1; }
        cluster="$2"
        shift 2
        ;;
      --cluster=*)
        cluster="${1#*=}"
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Error: Unknown option: $1" >&2
        return 1
        ;;
      *)
        echo "Error: beaker-session takes no positional arguments" >&2
        return 1
        ;;
    esac
  done

  (( $# == 0 )) || { echo "Error: beaker-session takes no positional arguments" >&2; return 1; }

  local author session node beaker_json

  beaker_json="$(beaker account whoami --format=json)" || return $?
  author="$(printf '%s' "$beaker_json" | jq -r '.[].name')" || return $?
  [[ -n "$author" ]] || { echo "Error: Could not determine beaker author." >&2; return 1; }

  # Look for an existing session
  beaker_json="$(beaker session list --author="$author" --cluster="$cluster" --format=json)" || return $?
  session="$(printf '%s' "$beaker_json" | jq -r '.[0].id // empty')" || return $?

  if [[ -n "$session" && "$force" -eq 0 ]]; then
    echo "Using existing session: $session"
  else
    beaker_json="$(
      beaker session create --detach --bare \
        --cluster "$cluster" \
        --workspace "ai2/open-instruct-dev" \
        --budget "ai2/allennlp" \
        --mount src=weka,ref=oe-eval-default,subpath=finbarrt,dst=/root \
        --mount src=weka,ref=oe-adapt-default,dst=/weka/oe-adapt-default \
        --mount src=weka,ref=oe-training-default,dst=/weka/oe-training-default \
        --workdir=/root \
        --no-update-default-image=false \
        --save-image \
        --mount src=secret,ref=ssh-key,dst=/secret-files/.ssh/id_rsa \
        --mount src=secret,ref=ai2-creds,dst=/secret-files/.ai2-creds \
        --mount src=secret,ref=git-config,dst=/secret-files/.gitconfig \
        --mount src=secret,ref=beaker-config,dst=/secret-files/.beaker/config.yml
    )" || return $?
    session="$(printf '%s' "$beaker_json" | sed -n 's/Starting session \([^ ]*\) .*/\1/p')" || return $?

    [[ -n "$session" ]] || { echo "Error: Failed to create a new session." >&2; return 1; }
    echo "Created new session: $session"
  fi

  beaker_json="$(beaker session get "$session" --format=json)" || return $?
  node="$(printf '%s' "$beaker_json" | jq -r '.[].session.envVars[] | select(.name=="BEAKER_NODE_HOSTNAME") | .value')" || return $?

  [[ -n "$node" ]] || { echo "Error: Could not determine node hostname for session $session" >&2; return 1; }

  # Always use mosh (no fallback)
  mosh "$author@$node" -- beaker session attach "$session"
}
