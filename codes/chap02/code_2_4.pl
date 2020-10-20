#!perl -w
use strict;

# 2 点 (x1, y1) と (x2, y2) との距離を求める関数
sub calc_dist {
    my ($x1, $y1, $x2, $y2) = @_;
    return sqrt(($x1 - $x2) * ($x1 - $x2) + ($y1 - $y2) * ($y1 - $y2));
}

# 入力データを受け取る
chomp(my $N = <STDIN>);
my (@x, @y);
for (my $i = 0; $i < $N; ++$i) {
    chomp($x[$i] = <STDIN>);
    chomp($y[$i] = <STDIN>);
}

# 求める値を、十分大きい値で初期化しておく
my $minimum_dist = 100000000.0;

# 探索開始
for (my $i = 0; $i < $N; ++$i) {
    for (my $j = $i + 1; $j < $N; ++$j) {
        # (x[i], y[i]) と (x[j], y[j]) との距離
        my $dist_i_j = calc_dist($x[$i], $y[$i], $x[$j], $y[$j]);
        
        # 暫定最小値 minimum_dist を dist_i_j と比べる
        if ($dist_i_j < $minimum_dist) {
            $minimum_dist = $dist_i_j;
        }
    }
}

# 答えを出力する
print "$minimum_dist\n";
