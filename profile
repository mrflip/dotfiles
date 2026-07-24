# -*- mode: sh;-*-
set +o history
# if [ "$PROFILE_DEBUG" = "debug" ] ; then echo "Into .profile" >&2; fi

export ANDROID_SDK=/Users/flip/Library/Android/sdk
export PATH=$HOME/Library/Android/sdk/platform-tools:/opt/homebrew/bin:$PATH
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . $HOME/.asdf/asdf.sh
fi
export PATH="$HOME/bin:$PATH"

# From here on only for interactive shells
if [ "$PS1" ]; then
  export GIT_TERMINAL_PROMPT=1
  . $HOME/.bash/prompt
  # . $HOME/.bash/cheat
fi

set -o history
