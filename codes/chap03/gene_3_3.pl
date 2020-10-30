#!perl -w
use strict;
sub a_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print join(" ", map { a_val } 1 .. $N) . "\n";
