#!perl -w
use strict;
sub K_val {          100   }
sub a_val { int(rand(100)) }
sub b_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print K_val . "\n";
print join(" ", map { a_val } 1 .. $N) . "\n";
print join(" ", map { b_val } 1 .. $N) . "\n";
