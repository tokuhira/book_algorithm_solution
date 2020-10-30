#!perl -w
use strict;
use constant INF => 1 << 60;
chomp(my $N = <STDIN>);
print "$N\n";
for (my $l = 0; $l <= $N; ++$l) {
    for (my $r = 0; $r <= $N; ++$r) {
        print " " if 0 < $r;
        my ($value, $width) = (0, $r - $l);
	if (0 < $width) {
	    $value = 1 + int(rand($width + $N));
	} elsif ($width < 0) {
	    $value = INF;
	}
	print $value;
    }
    print "\n";
}
