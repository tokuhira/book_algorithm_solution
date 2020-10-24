#!perl -w
use strict;
chomp(my $N = <STDIN>);
print "$N\n";
for (my $l = 0; $l <= $N; ++$l) {
    for (my $r = 0; $r <= $N; ++$r) {
        my ($value, $width) = (0, $r - $l);
	if (0 < $width) {
	    $value = 1 + int(rand($width + $N));
	} elsif ($width < 0) {
	    $value = 1 << 60;
	}
	print "$value\n";
    }
}
