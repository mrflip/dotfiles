. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc

export PATH=${HOME}/.asdf/shims:${HOME}/.asdf/bin:${HOME}/Library/Android/sdk/platform-tools:${HOME}/bin:${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/libexec:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin

###-tns-completion-start-###
if [ -f ${HOME}/.tnsrc ]; then
    source ${HOME}/.tnsrc
fi
###-tns-completion-end-###

export TOOKNAME=flip

# . $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.local/bin:$PATH"
