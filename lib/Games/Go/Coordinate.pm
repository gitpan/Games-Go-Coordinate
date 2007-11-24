package Games::Go::Coordinate;

use warnings;
use strict;


our $VERSION = '0.03';


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

Games::Go::Coordinate inherits from L<Class::Accessor::Complex>.

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    carp(), cluck(), croak(), flatten(), mk_abstract_accessors(),
    mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor(), subname()

=head1 METHODS

=over 4

=item new

    my $obj = Games::Go::Coordinate->new;
    my $obj = Games::Go::Coordinate->new(%args);

Creates and returns a new object. The constructor will accept as arguments a
list of pairs, from component name to initial value. For each pair, the named
component is initialized by calling the method of the same name with the given
value. If called with a single hash reference, it is dereferenced and its
key/value pairs are set as described before.

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

=head1 VERSION 
                   
This document describes version 0.03 of L<Games::Go::Coordinate>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-games-go-coordinate@rt.cpan.org>>, or through the web interface at
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

