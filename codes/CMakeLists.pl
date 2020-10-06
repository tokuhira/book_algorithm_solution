#!env perl
use strict;
use warnings FATAL => 'all';
use File::Basename 'fileparse';

# 諸々の設定（他に、出力部にもマジックナンバーがあるので注意）
my $project = "book_algorithm_solution";
my $suffix = ".cpp";
my $pattern = "*/*$suffix";

# CMakeLists.txt を出力
$" = "\n";
print <<__EOT__;
cmake_minimum_required(VERSION 3.1)
project( $project )
set(CMAKE_CXX_STANDARD 11)
@{[
    map { "add_executable( " . (fileparse($_, $suffix))[0] . " $_ )" }
    sort { naturally($a, $b) }
    grep { targetp($_) }
    glob $pattern
]}
__EOT__

# ちょっと自然な感じにソートするための比較関数
sub naturally {
    my ($a, $b) = @_;
    return 0 if $a eq $b;
    return $a cmp $b if $a xor $b;
    my ($a1, $a2, $a3) = ($a =~ /^(\d*)(\D*)(.*)/);
    my ($b1, $b2, $b3) = ($b =~ /^(\d*)(\D*)(.*)/);
    return $a1 <=> $b1 if ($a1 or $b1) and $a1 != $b1;
    return $a2 cmp $b2 if ($a2 or $b2) and $b2 ne $b2;
    return naturally($a3, $b3);
}

# ビルド対象とするかの簡易判定（超手抜き版）
sub targetp {
    local $_;
    my ($path) = @_;
    open(my $fh, "<", $path) or die;
    while (<$fh>) {
        return 1 if /int main\(\)/;
    }
    return 0;
}
