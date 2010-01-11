#!/bin/sh

DIR=`pwd`
PROJNAME=${1:-`basename $DIR`}
shift
FILES=${*:-.}
ARCHIVE=${ARCHIVE:-$HOME/archive}

tarfilename=${PROJNAME}-bkup-`datename`.tar.gz

echo "From project name  \"$PROJNAME\""
echo "     backing up    \"$FILES\""
echo "     to            \"$tarfilename\""
echo "     in archivedir \"$ARCHIVE\""
echo -n "If this looks OK, "; pauseme
tar cvf - ${FILES} | gzip > ${ARCHIVE}/$tarfilename


