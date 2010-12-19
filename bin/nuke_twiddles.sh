#!/usr/bin/env bash
timestamp=`date "+%Y%m%d%H%M%S"`
bkupdir=/tmp/twiddles/$timestamp
if [[ "$1" =~ ^--patt=(.*) ]] ; then
  patt=${BASH_REMATCH[1]}
  shift
else
  patt='*~'
fi
echo "Ditching files that match $patt into ${bkupdir}"
mkdir -p $bkupdir
find "${@-.}" -name "$patt" -print -exec mv -b {} $bkupdir/ \;
