#!/usr/bin/env bash
timestamp=`date "+%Y%m%d%H%M%S"`
bkupdir=/tmp/twiddles/$timestamp
echo "Ditching removed files into ${bkupdir}"
mkdir -p $bkupdir
find ${@-.} -name '*~' -print -exec mv -b {} $bkupdir/ \;
