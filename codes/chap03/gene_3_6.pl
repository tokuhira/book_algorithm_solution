#!perl -w
use strict;
sub W_val {             100   }
sub a_val { 1 + int(rand(99)) }
chomp(my $N = <STDIN>);
print "$N\n";
print W_val . "\n";
print a_val . "\n" for 1 .. $N;
