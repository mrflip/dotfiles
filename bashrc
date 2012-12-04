#!/usr/bin/env bash
set     +o history


# From here on only for interactive shells
if [ "$PS1" ]; then 
  source $HOME/.bash/aliases
  
  source $HOME/.bash/functions
  source $HOME/.bash/config
fi

set     -o history
