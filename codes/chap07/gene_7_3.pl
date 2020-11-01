#!perl -w
use strict;
sub A_val {     int(rand(101)) }
sub B_val { 1 + int(rand(100)) }
chomp(my $N = <STDIN>);
print "$N\n";
print A_val . " " . B_val . "\n" for 1 .. $N;
