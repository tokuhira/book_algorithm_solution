#!perl -w
use strict;

sub chmin (\[$]$) {
    if (${$_[0]} > $_[1]) {
	${$_[0]} = $_[1];
    }
}

use constant INF => 1 << 29; # 十分大きな値 (ここでは 2^29 とする)

# 入力
chomp(my $S = <STDIN>);
chomp(my $T = <STDIN>);

# DP テーブル定義
my $dp = [map { [(INF) x (1 + length $T)] } (0 .. length $S)];

# DP 初期条件
$dp->[0]->[0] = 0;

# DPループ
for (my $i = 0; $i <= length $S; ++$i) {
    for (my $j = 0; $j <= length $T; ++$j) {
	# 変更操作
	if ($i > 0 and $j > 0) {
	    if (substr($S, $i - 1, 1) eq substr($T, $j - 1, 1)) {
		chmin($dp->[$i]->[$j], $dp->[$i - 1]->[$j - 1]);
	    } else {
		chmin($dp->[$i]->[$j], $dp->[$i - 1]->[$j - 1] + 1);
	    }
	}

	# 削除操作
	if ($i > 0) {
	    chmin($dp->[$i]->[$j], $dp->[$i - 1]->[$j] + 1);
	}

	# 挿入操作
	if ($j > 0) {
	    chmin($dp->[$i]->[$j], $dp->[$i]->[$j - 1] + 1);
	}
    }
}

# DP テーブル確認
#use Data::Dumper::Concise;
#warn Dumper $dp;

# 答えの出力
print "$dp->[length $S]->[length $T]\n";
