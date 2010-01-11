( find . -type f -exec md5 {} \; ) > /tmp/dupeshash.txt
cat  /tmp/dupeshash.txt  | perl -e 'use Data::Dumper; for $_ (<>) { m/^MD5 \((.*)\) = (\w+)$/; push @{$hashes{$2}}, $1; }; my $pad = " "x34; for $hash (keys %hashes) { @files = @{$hashes{$hash}}; next unless scalar @files > 1; printf "%s: %s\n", $hash, join "\n$pad",@files; }'
