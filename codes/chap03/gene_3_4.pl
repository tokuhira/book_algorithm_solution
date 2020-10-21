#!perl -w
use strict;
sub K_val {          100   }
sub a_val { int(rand(100)) }
sub b_val { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print K_val . "\n";
print a_val . "\n" for 1 .. $N;
print b_val . "\n" for 1 .. $N;
