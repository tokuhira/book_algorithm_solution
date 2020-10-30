#!perl -w
use strict;
sub h_val {     int(rand(11)) }
sub s_val { 1 + int(rand(10)) }
chomp(my $N = <STDIN>);
print "$N\n";
print h_val . " " . s_val . "\n" for 1 .. $N;
