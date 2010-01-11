xmllint -format $@
#       |
# 	perl -e '
# 	    local $/; $_=<>; # chomp
# 	    s/[\r\n]{1,2}\s*(?!<[^\/]|\s)/ /gs;
# 	    print ;
# 	'
