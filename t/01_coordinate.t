#!/usr/bin/env perl

use warnings;
use strict;
use Games::Go::Coordinate;
use Test::More tests => 12;

my $coord = Games::Go::Coordinate->new(x => 4, y => 10);
is($coord->x, 4, 'x coordinate');
is($coord->y, 10, 'y coordinate');
is($coord->as_list, '(4,10)', 'as list');
is("$coord", "dj", 'as sgf');

$coord->translate(2, 2);
is($coord->x, 6, 'translated x coordinate');
is($coord->y, 12, 'translated y coordinate');

$coord = $coord->new_from_sgf_coordinate('bc');
is($coord->x, 2, 'x coordinate from "bc"');
is($coord->y, 3, 'x coordinate from "bc"');

my $c1 = Games::Go::Coordinate->new(x => 4, y => 3);
my $c2 = Games::Go::Coordinate->new(x => 4, y => 10);
my $c3 = Games::Go::Coordinate->new(x => 7, y => 10);

is($c1, $c1, 'equality test');
ok($c2 gt $c1, '(4,10) gt (4,3)');
ok($c3 gt $c1, '(7,10) gt (4,3)');
ok($c3 gt $c2, '(7,10) gt (4,10)');
