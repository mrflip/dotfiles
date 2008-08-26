# ~/.profile
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

####################### System  ################################
test -r /sw/bin/init.sh && . /sw/bin/init.sh

source ~/.bash/paths
source ~/.bash/config
source ~/.noyuo/host_nicknames

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
