#!/usr/bin/env bash
set     +o history

source ~/.bash/paths


export TOOKNAME=flip
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export ASDF_DATA_DIR=/Users/flip/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"

export MYSQL_DATADIR=/data/db/mysql
export MYSQL_BASEDIR=$HOME/.asdf/installs/mysql/5.7.30

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# From here on only for interactive shells
case $- in
    *i*)
      source $HOME/.bash/prompt
      source $HOME/.bash/aliases
      source $HOME/.bash/functions
      source $HOME/.bash/config
      source $HOME/.bash/private
    ;;
esac

set     -o history


