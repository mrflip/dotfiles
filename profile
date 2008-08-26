# ~/.profile
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

####################### System  ################################
test -r /sw/bin/init.sh && . /sw/bin/init.sh

source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/config
source ~/.noyuo/bash_profile

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
