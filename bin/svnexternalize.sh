svn propset svn:externals "`svn info * | perl -e 'local $/; $_=<>; for my $svnext (m/(Path: .*\nURL: .*)/mg) { next if $svnext =~ m/infochimp/; $svnext =~ m/^Path: (.*)\nURL: (.*)/; printf "%-35s %s\n", $1, $2; }'`" "$@"
svn propget svn:externals "$@"
