#!perl -w
use strict;
sub v_val { 1 }
sub a_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print v_val . "\n";
print a_val . "\n" for 1 .. $N;
