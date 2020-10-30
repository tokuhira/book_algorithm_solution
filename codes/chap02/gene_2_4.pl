#!perl -w
use strict;
sub xy_val { -1.0 + 2.0 * rand }
chomp(my $N = <STDIN>);
print "$N\n";
print xy_val . " " . xy_val . "\n" for 1 .. $N;
