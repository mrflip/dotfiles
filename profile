# -*- mode: sh;-*-
# ~/.profile 

# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

####################### System  ################################
test -r /sw/bin/init.sh && . /sw/bin/init.sh

if    uname -a | egrep 'Darwin.*9\.[6789]' > /dev/null 2>&1 ; then
  export MACHINE=OSX
elif uname -a | egrep '^Linux' > /dev/null 2>&1 ; then
  # grep -i ubuntu /etc/issue 
  export MACHINE=LINUX
fi

source ~/.bash/paths
source ~/.bash/functions
source ~/.bash/config

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
