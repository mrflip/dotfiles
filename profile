# -*- mode: sh;-*-
set +o history
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi
export GIT_TERMINAL_PROMPT=1

source ~/.bash/paths
if [ -f ~/.bashrc  ]; then source ~/.bashrc  ; fi

# export RBENV_GEMSETS=sink
# eval "$(rbenv init -)"

# From here on only for interactive shells
if [ "$PS1" ]; then
  source ~/.bash/prompt
  source ~/.bash/cheat
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

set -o history
