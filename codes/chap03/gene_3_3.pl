#!perl -w
use strict;
sub a_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print a_val . "\n" for 1 .. $N;
