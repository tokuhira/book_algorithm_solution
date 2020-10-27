#!perl
use strict;
use warnings FATAL => 'all';
use List::Util qw(sum);
# コインの定義
my @coin = (500, 100, 50, 10, 5, 1);
sub num_base { int(rand(11)) };
sub num_plus {  int(rand(6)) };

# コインの定義と支払い金額
my %coin = map { $_ => num_base } @coin;
my $X = sum(map { $_ * $coin{$_} } @coin);
print "$X\n";

# プラスした枚数
$coin{$_} += num_plus for @coin;
print $coin{$_} . "\n" for @coin;

# 単純解（コイン定義の一般化には未対応）
my $result = 0;
for my $coin (@coin) {
    my $add = int($X / $coin);
    $add = $coin{$coin} if ($add > $coin{$coin});
    $X -= $coin * $add;
    $result += $add;
}
warn "$result\n";
