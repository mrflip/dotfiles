
test -r /sw/bin/init.sh && . /sw/bin/init.sh
source ~/.bash/aliases

####################### Interactive Term Stuff ######################
#
# From here on only for interactive shells
#
if [ "$PS1" ]; then 
  source ~/.bash/prompt
  source ~/.bash/functions
  source ~/.bash/completions
  source ~/.bash/cheat
fi

source ~/.bash/paths
