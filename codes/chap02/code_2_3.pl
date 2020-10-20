#!perl -w
use strict;

chomp(my $N = <STDIN>);

for (my $i = 2; $i <= $N; $i += 2) {
    print "$i\n";
}
