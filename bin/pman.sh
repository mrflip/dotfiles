#!/bin/bash

pmanpage=${!#} #last arg
pmanargs=$*
pmanfile=`tempfile -p"pman-" -s"-$pmanpage"`

# # Simple
# man -t $pmanargs | ps2pdf - $pmanfile | open -a /Applications/Accessories/Preview.app $pmanfile 

# Slightly Faster
# man -t $pmanargs | ps2pdf - $pmanfile
groff -mandoc `man -w $pmanargs` | ps2pdf - $pmanfile
if [[ ${PIPESTATUS[*]} == "0 0" ]] ; then
     echo "Previewing man $pmanargs" >&2
     open -a /Applications/Accessories/Preview.app "$pmanfile"
fi

# # Slightly Suckier
# if groff -mandoc -Tdvi `man -w "$pmanargs"` > "$pmanfile".dvi && \
#   dvips -q -f -o "$pmanfile" -sDEVICE=pdfwrite "$pmanfile".dvi ; then
#      echo "Previewing man $pmanargs" >&2
#      open -a /Applications/Accessories/Preview.app "$pmanfile"
# fi

