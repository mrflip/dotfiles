#PROFILE_DEBUG=debug
if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .bash_profile" >&2 ; fi

####################### Do .profile     ##############################
source ~/.profile


if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Done .bash_profile" >&2 ; fi
