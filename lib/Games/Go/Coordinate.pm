package Games::Go::Coordinate;

use warnings;
use strict;


our $VERSION = '0.02';


use base qw(Class::Accessor::Complex);


use overload
    '""'  => 'stringify',
    'cmp' => 'str_cmp';


__PACKAGE__
    ->mk_new
    ->mk_accessors(qw(x y));


# accept something like 'ac' and set x=1, y=3
sub set_sgf_coordinate {
    my ($self, $coord) = @_;
    my ($x, $y) = map { ord($_)-96 } split // => lc($coord);
    $self->x($x);
    $self->y($y);
}


sub new_from_sgf_coordinate {
    my ($class, $coord) = @_;
    my $self = $class->new;
    $self->set_sgf_coordinate($coord);
    $self;
}


sub to_sgf {
    my $self = shift;
    join '' => map { chr($_+96) } $self->x, $self->y;
}


sub as_list {
    my $self = shift;
    sprintf '(%d,%d)', $self->x, $self->y;
}


sub stringify {
    my $self = shift;
    $self->to_sgf;
}


sub str_cmp {
    my ($lhs, $rhs, $reversed) = @_;
    $_ = "$_" for $lhs, $rhs;
    ($lhs, $rhs) = ($rhs, $lhs) if $reversed;
    $lhs cmp $rhs;
}


sub translate {
    my ($self, $dx, $dy) = @_;
    $self->x($self->x + $dx);
    $self->y($self->y + $dy);
}


1;


__END__

=head1 NAME

Games::Go::Coordinate - represents a board coordinate in the game of Go

=head1 SYNOPSIS

    use Games::Go::Coordinate;

    my $c1 = Games::Go::Coordinate->new(x => 4, y => 3);
    my $c2 = Games::Go::Coordinate->new(x => 4, y => 10);
    if ($c2 gt $c1) { ... }

=head1 DESCRIPTION

This class represents a board coordinate in the game of Go. Coordinate objects
can be compared (as strings) to see whether two ranks are equal or whether one
rank is higher than the other. Coordinate objects stringify to the SGF
notation (for example, C<(4,10)> stringifies to C<dj>.

=head1 METHODS

Additionally, this class defines the following methods:

=over 4

=item new

    my $coord = Games::Go::Coordinate->new(x => 7, y => 12);

Constructs a new objects. The constructor accepts named arguments - that is, a
hash - and will set the hash values on the accessor methods denoted by the
keys.

=item x

    $coord->x(19);

Sets or gets the horizontal part of the coordinate. No bounds checking is done
as it is conceivable to have boards with more than 19 lines, and for it might
be useful to have virtual negative coordinates.

=item clear_x

Clears the horizontal part of the coordinate.

=item y

    $coord->y(13);

Sets or gets the vertical part of the coordinate.

=item clear_y

Clears the vertical part of the coordinate.

=item set_sgf_coordinate

    $coord->set_sgf_coordinate('cf');

Takes a coordinate in SGF notation and sets C<x()> and C<y()> from it.

=item new_from_sgf_coordinate

    my $cord = Games::Go::Coordinate->new_from_sgf_coordinate('cf');

Alternative constructor that accepts an SGF coordinate and sets C<x()> and
C<y()> from it.

=item to_sgf

Returns the coordinate in SGF notation. This is also how the coordinate object
stringifies.

=item as_list

Returns the coordinate in C<(x,y)> notation. For example, it might return a
string C<(16,17)>.

=item translate

    $coord->translate(2, -3);

Takes as arguments - in that order - a horizontal delta and a vertical delta
and translates the coordinate by those deltas.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<gamesgocoordinate> tag.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-games-go-coordinate@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

