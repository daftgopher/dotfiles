setopt PROMPT_SUBST

precmd() { $RANDOM 2> /dev/null }

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function pick_random_emoji {
  local prompt_emoji=("🦆" "😺" "🐈" "🐇" "🌲" "👉" "⛩ " "👾")
  local index=$((RANDOM % ${#prompt_emoji[@]} + 1))
  echo ${prompt_emoji[$index]}
}

PROMPT='⛺️ %F{10}%n%f:%F{38}%1~%F{11}$(parse_git_branch)%f $(pick_random_emoji) '
