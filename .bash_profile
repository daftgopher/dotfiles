JAVA_HOME=$(/usr/libexec/java_home)

# Git branch parsing
function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Pick random emoji for prompt
function pick_random_emoji {
  local prompt_emoji=(🦆 😺 🐈 🐇 🌲 👉 👾)
  local index=$((RANDOM % ${#prompt_emoji[@]}))
  echo ${prompt_emoji[$index]}
}

export PS1="🧶  \e[0;92m\u\e[m:\e[0;36m\W\e[m\e[0;33m\$(parse_git_branch)\\e[m \$(pick_random_emoji) "

# Raspberry pi address (create file with format if it does not exist here)
if [ -f ~/.pi/piaddress ]; then
  PI_ADDRESS=$(head -n 1 ~/.pi/piaddress)
fi

# Autocomplete for Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

python3 /Users/mattwaldron/bash_scripts/pokemons.py

# ALIASES
#
# Pi
alias pibox="ssh $PI_ADDRESS"

# Docker
alias d="docker"
alias dc="docker-compose"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias ll="ls -lG"

function make_local_python_package 
{
  local directory=${1} 
  if [ -z "${directory}" ]; then
    echo 'No directory defined'
  else
    cp -rf ${directory}/ /usr/local/lib/python3.7/site-packages/${directory}/
    echo "Python packaged created in /usr/local/lib/python3.7/site-packages/${directory}/"
  fi
}

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
