export ZSH="/Users/mattwaldron/.oh-my-zsh"
ZSH_THEME="daftgopher"
plugins=(git fasd node npm github)
fpath=( ~/.zfunc "${fpath[@]}" )

source $ZSH/oh-my-zsh.sh

setopt NO_CASE_GLOB
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# FASD
eval "$(fasd --init auto)"
alias j="fasd_cd -d" # behave like autojump

# Aliases
alias d="docker"
alias dc="docker-compose"

alias kc="kubectl"
alias nv="nvim"

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"

# Functions
function penv () { env $(cat .env) poetry shell }

# NVM
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh

# PATH stuff
export GO_PATH="$HOME/go"
export GO_BIN="$GO_PATH/bin"
export CARGO_BIN="$HOME/.cargo/bin"
export STANDARD_BINS="$HOME/bin:/usr/local/bin:/sbin:/usr/sbin"
export POETRY_BIN="$HOME/.poetry/bin"
export FLUTTER_BIN="$HOME/.flutter/flutter/bin"

export PATH="$STANDARD_BINS:$CARGO_BIN:$GO_BIN:$POETRY_BIN:$FLUTTER_BIN:$PATH"

