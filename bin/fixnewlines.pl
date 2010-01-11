#!/usr/bin/perl -w
use strict;
use File::Copy;
use File::Basename;
use Getopt::Long;

# Map newline style to system name
my %nl_to_type  = qw{ \\r mac \\r\\n dos \\n unix };
my %type_to_nl  = ( 'mac'=>"\x0d", 'dos'=>"\x0d\x0a", 'unix'=>"\x0a" );

sub max($$) { return (sort {$a <=> $b} @_)[1]; }

# make filenames line up.
my $fnlen = 0;
for my $filename (@ARGV) { $fnlen = max($fnlen, length($filename)); }
$fnlen += 1;

# ***************************************************************************
# Handle options
#
my ($opt_fix, $opt_type);
GetOptions ('fix' => \$opt_fix, 'type=s' => \$opt_type);

# emit this flavor of newline
my $out_nl;
if (defined $opt_fix) {
    if    (! defined $opt_type)             { die "Must give a --type= option (dos, mac or unix) to fix newlines."; }
    elsif (! exists $type_to_nl{$opt_type}) { die "--type= option needs one of dos, mac or unix, not '$opt_type'."; }
    else                                    { $out_nl = $type_to_nl{$opt_type}; }
}


# ***************************************************************************
# Process files
#
for my $filename (@ARGV) {

    # Open non-directories
    next if -d $filename;
    open FILE, "<$filename" or do { print STDERR "Can't read from $filename: $!\n"; next; };
    # slurp
    local $/ = undef;
    my $conts = <FILE>;
    close FILE;

    # don't bother with empty
    if (length($conts) < 1) { printf "%-${fnlen}s empty\n", "$filename:"; next }

    # identify ending -- ^Z is a DOS thing.
    $conts =~ m/((?:(?:\x0d\x0a)|\x0d|\x0a)?\x1a?)$/so;
    my $end = $1;
    $end = "none" unless $end;
    $end =~ s/\x0d+/\\r/gso; 
    $end =~ s/\x0a+/\\n/gso;
    $end =~ s/\x1a/^Z/gso;

    # count each newline
    my %nls;
    for my $nl ($conts =~ m/[^\x0d\x0a]*((?:\x0d\x0a)|\x0d|\x0a)/gso) {
	$nl =~ s/\x0d/\\r/gso; 
	$nl =~ s/\x0a/\\n/gso;
	$nls{$nl}++;
    }

    # itemize the types found
    my @nlcount = ();
    for my $nl (sort keys %nls) {
	my $nlc = $nls{$nl};
	push @nlcount, sprintf "%-6s => %4d", $nl, $nlc;
    }

    my $systype;
    if (1 == scalar keys %nls) { $systype = $nl_to_type{(keys %nls)[0]};  }
    else                       { $systype = "weird"; }

    my $binaryfile = -B $filename;

    printf "%-${fnlen}s Looks like %-5s ends with %-6s %s(%s)", "$filename:", 
        $systype, $end, ($binaryfile ? "assumed to be binary ":''), join "\t",@nlcount;

    if ( (defined $opt_fix) && (! $binaryfile) ) {
	my ($basefilename, $directories) = fileparse($filename);
	my $bkupfile = "/tmp/fixnl-$basefilename";
	copy($filename,$bkupfile) or die "Copy failed: $!";
	print " (backed up to $bkupfile)";

	open FILE, ">$filename" or die "Can't write to $filename: $!\n";
	# convert each newline into the right flavor.
	$conts =~ s/(?:(?:\x0d\x0a)|\x0d|\x0a)?\x1a?$/$out_nl/so;
	$conts =~ s/(?:(?:\x0d\x0a)|\x0d|\x0a)/$out_nl/gso;
	print FILE $conts;
	close FILE;
    }

    print "\n";
}
