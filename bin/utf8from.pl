#!/usr/bin/perl

use strict;
use encode;

( @ARGV == 1 and $ARGV[0] =~ /^\w[-\w]+$/ and ! -t )
    or do {
	print "$_\n" for(Encode->encodings(":all"));

	die "Usage: $0 inp-enc < file.inp-enc > file.utf8\n";
    };

my $inp_enc = sprintf( ":encoding(%s)", shift );
binmode STDIN, $inp_enc;
binmode STDOUT, ":utf8";

print while (<>);
