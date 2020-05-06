#!/usr/bin/env bash
set     +o history

# From here on only for interactive shells
if [ "$PS1" ]; then
  source $HOME/.bash/aliases

  source $HOME/.bash/functions
  source $HOME/.bash/config
  source $HOME/.bash/private
fi

# ###-tns-completion-start-###
# if [ -f /Users/flip/.tnsrc ]; then
#     source /Users/flip/.tnsrc
# fi
###-tns-completion-end-###

# tabtab source for packages
# uninstall by removing these lines
# [ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

set     -o history
