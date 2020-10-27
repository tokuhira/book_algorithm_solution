#!perl
use strict;
use warnings FATAL => 'all';
use List::Util qw(sum);
sub num_base { int(rand(11)) };
sub num_plus {  int(rand(6)) };

# コインの定義と支払い金額
my %coin = map { $_ => num_base } (500, 100, 50, 10, 5, 1);
print sum(map { $_ * $coin{$_} } keys %coin) . "\n";

# プラスした枚数
$coin{$_} += num_plus for keys %coin;
print $coin{$_} . "\n" for sort { $b <=> $a } keys %coin;
