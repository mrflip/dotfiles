# http://woss.name/2005/09/06/bash-completion-for-mac-os-x-open/

if [ "`uname`" = "Darwin" ]; then
    _open() {
        local cur prev
        COMPREPLY=()
        cur=${COMP_WORDS[COMP_CWORD]}
        prev=${COMP_WORDS[COMP_CWORD-1]}
        if [ "${prev}" = -a ]; then
            local IFS=$'\n'
            COMPREPLY=( $(
                    compgen -W "$(
                      /bin/ls -d1 /Applications/*/*.app /Applications/*.app | \
                      sed 's|^.*/\([^/]*\)\.app.*|\1|;s/\ /\\ /g'
                    )" -- $cur)
                )
            return 0
        fi
    }
    complete -F _open -o default open
fi
