#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

{
    package Heap;
    
    sub new { bless( { heap => [] }, shift ) }
    
    # ヒープに値 x を挿入
    sub push {
        my ( $self, $x ) = @_;
        my $heap = $self->{heap};
        push @$heap, $x;    # 最後尾に挿入
        my $i = $#$heap;    # 挿入された頂点番号
        while ( $i > 0 ) {
            my $p = int( $i - 1 ) / 2;    # 親の頂点番号
            last if $heap->[$p] >= $x;    # 逆転がなければ終了
            $heap->[$i] = $heap->[$p];    # 自分の値を親の値にする
            $i = $p;                      # 自分は上に行く
        }
        $heap->[$i] = $x;                 # x は最終的にはこの位置にもってくる
    }
    
    # 最大値を知る
    sub top {
        my ($self) = @_;
        my $heap = $self->{heap};
        @$heap ? $heap->[0] : -1;
    }
    
    # 最大値を削除
    sub pop {
        my ($self) = @_;
        my $heap = $self->{heap};
        return undef unless @$heap;
        my $x = pop @$heap;    # 頂点にもってくる値
        my $i = 0;             # 根から降ろしていく
        while ( $i * 2 + 1 < @$heap ) {
    
            # 子頂点同士を比較して大きい方を child1 とする
            my ( $child1, $child2 ) = ( $i * 2 + 1, $i * 2 + 2 );
            if ( $child2 < @$heap and $heap->[$child2] > $heap->[$child1] ) {
                $child1 = $child2;
            }
            last if $heap->[$child1] <= $x;    # 逆転がなければ終了
            $heap->[$i] = $heap->[$child1];    # 自分の値を子頂点の値にする
            $i = $child1;                      # 自分は下に行く
        }
        $heap->[$i] = $x;                      # x は最終的にはこの位置にもってくる
    }
}
    
{
    package main;
    #use Data::Dumper::Concise;
    
    my $h = new Heap;
    $h->push($_) for 5, 3, 7, 1;
    #warn Dumper $h;
    
    print $h->top . "\n"; # 7
    $h->pop;
    print $h->top . "\n"; # 5
    
    $h->push(11);
    print $h->top . "\n"; # 11
    
    #warn Dumper $h;
}
