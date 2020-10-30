#!perl -w
use strict;
sub W_val      {          200   }
sub weight_val { int(rand(100)) }
sub value_val  { int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print W_val . "\n";
print weight_val . " " . value_val . "\n" for 1 .. $N;
