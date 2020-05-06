. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

###-tns-completion-start-###
if [ -f /Users/flip/.tnsrc ]; then 
    source /Users/flip/.tnsrc 
fi
###-tns-completion-end-###
