#!/usr/bin/env bash
source ~/.bash/paths
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
  source ~/.bash/config
fi
