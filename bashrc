####################### Interactive Term Stuff ######################
#
# From here on only for interactive shells
#
if [ "$PS1" ]; then 
  source .bash/prompt
  source .bash/functions

# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Done .bashrc" >&2 ; fi
fi

