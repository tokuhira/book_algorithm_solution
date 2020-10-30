#!perl -w
use strict;
sub v_val { 1 }
sub a_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print v_val . "\n";
print join(" ", map { a_val } 1 .. $N)  . "\n";
