# -*- mode: sh;-*-
set +o history
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

source ~/.bash/rbenv
source ~/.bash/paths
if [ -f ~/.bashrc  ]; then source ~/.bashrc  ; fi

# From here on only for interactive shells
if [ "$PS1" ]; then 
  source ~/.bash/prompt
  source ~/.bash/cheat
fi

set -o history
