#!perl
use strict;
use warnings FATAL => 'all';
use List::Util qw(sum);

# コインの定義
my @type = ( 500, 100, 50, 10, 5, 1 );
sub num_base { int( rand(11) ) }
sub num_plus { int( rand(6) ) }

# コインの初期化と支払い金額の確定
my %a = map { $_ => num_base } @type;
my $X = sum( map { $_ * $a{$_} } @type );
print "$X\n";

# 支払いの自由度を上げるため枚数を追加して出力
$a{$_} += num_plus for @type;
print $a{$_} . "\n" for @type;

# 最小支払い枚数を調べる
use constant INF => 1 << 29;    # 十分大きな値 (ここでは 2^29 とする)
sub chmin (\[$]$) { ${ $_[0] } = $_[1] if ${ $_[0] } > $_[1] }
my @a  = map { ($_) x $a{$_} } @type;                       # コインを枚数分展開する
my $n  = @a;                                                # コインの枚数
my $dp = [ map { [ (INF) x ( $X + 1 ) ] } ( 0 .. $n ) ];    # コインの枚数と支払い金額の DP テーブル
$dp->[0]->[0] = 0;                                          # 部分和の初期条件
for ( my $i = 0 ; $i < $n ; ++$i ) {
    for ( my $j = 0 ; $j <= $X ; ++$j ) {
        chmin( $dp->[ $i + 1 ]->[$j], $dp->[$i]->[ $j - $a[$i] ] + 1 ) if $j - $a[$i] >= 0;
        chmin( $dp->[ $i + 1 ]->[$j], $dp->[$i]->[$j] );
    }
}
warn "$dp->[$n]->[$X]\n"; # 想定解を標準エラー出力へ
