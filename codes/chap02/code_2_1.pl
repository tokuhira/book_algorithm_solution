#!perl -w
use strict;

chomp(my $N = <STDIN>);

my $count = 0;
for (my $i = 0; $i <= $N; ++$i) {
    ++$count;
}
