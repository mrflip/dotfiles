# -*- mode: sh;-*-
set +o history
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

####################### System  ################################
test -r /sw/bin/init.sh && . /sw/bin/init.sh
source ~/.bash/paths
if [ -f ~/.noyuo/host_nicknames ]; then source ~/.noyuo/host_nicknames ; fi

####################### Interactive Term Stuff ######################

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

source ~/.bash/rvm
set -o history
