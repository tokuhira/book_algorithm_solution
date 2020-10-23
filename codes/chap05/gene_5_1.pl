#!perl -w
use strict;
sub h_val { 1 + int(rand(10)) }
chomp(my $N = <STDIN>);
print "$N\n";
print h_val . "\n" for 1 .. $N;
