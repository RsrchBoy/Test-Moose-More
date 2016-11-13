#
# This file is part of Test-Moose-More
#
# This software is Copyright (c) 2012 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package Test::Moose::More::Utils;
our $AUTHORITY = 'cpan:RSRCHBOY';
$Test::Moose::More::Utils::VERSION = '0.041'; # TRIAL
# ABSTRACT: Various utility functions for TMM (and maybe others!)

use strict;
use warnings;

use Sub::Exporter::Progressive -setup => {

    exports => [ qw{
        get_mop_metaclass_for
        known_sugar
    } ],

    groups  => { default  => [':all'] },
};

use Carp 'croak';
use List::Util 1.33 qw( first all );
use Scalar::Util 'blessed';


sub get_mop_metaclass_for {
    my ($mop, $meta) = @_;

    # FIXME make this less... bad
    # short-circuit!  Better a special case here than *everywhere* else
    return blessed $meta
        if $mop eq 'class' || $mop eq 'role';

    # this code largely lifted from Moose::Util::MetaRole
    my $attr =
        first { $_ }
        map { $meta->meta->find_attribute_by_name($_) }
        ("${mop}_metaclass", "${mop}_class")
        ;

    croak "Cannot find attribute storing the metaclass for $mop in " . $meta->name
        unless $attr;

    my $read_method = $attr->get_read_method;

    return $meta->$read_method();
}


sub known_sugar () { qw{ has around augment inner before after blessed confess } }

!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Chad Etheridge Granum Karen TMM

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed

=head1 NAME

Test::Moose::More::Utils - Various utility functions for TMM (and maybe others!)

=head1 VERSION

This document describes version 0.041 of Test::Moose::More::Utils - released November 12, 2016 as part of Test-Moose-More.

=head1 FUNCTIONS

=head2 get_mop_metaclass_for $mop => $meta

Given a MOP name (e.g. attribute), rummage through $meta (a metaclass) to reveal the MOP's metaclass.

e.g.

    get_metaclass_for attribute => __PACKAGE__->meta;

=head2 known_sugar

Returns a list of all the known standard Moose sugar (has, extends, etc).

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Test::Moose::More|Test::Moose::More>

=item *

L<L<Moose::Util::MetaRole> -- for much of the "find the metaclass for X mop" code|L<Moose::Util::MetaRole> -- for much of the "find the metaclass for X mop" code>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/RsrchBoy/Test-Moose-More/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head2 I'm a material boy in a material world

=begin html

<a href="https://gratipay.com/RsrchBoy/"><img src="http://img.shields.io/gratipay/RsrchBoy.svg" /></a>
<a href="http://bit.ly/rsrchboys-wishlist"><img src="http://wps.io/wp-content/uploads/2014/05/amazon_wishlist.resized.png" /></a>
<a href="https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2FTest-Moose-More&title=RsrchBoy's%20CPAN%20Test-Moose-More&tags=%22RsrchBoy's%20Test-Moose-More%20in%20the%20CPAN%22"><img src="http://api.flattr.com/button/flattr-badge-large.png" /></a>

=end html

Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you if you feel like it ;)

L<Flattr|https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2FTest-Moose-More&title=RsrchBoy's%20CPAN%20Test-Moose-More&tags=%22RsrchBoy's%20Test-Moose-More%20in%20the%20CPAN%22>,
L<Gratipay|https://gratipay.com/RsrchBoy/>, or indulge my
L<Amazon Wishlist|http://bit.ly/rsrchboys-wishlist>...  If and *only* if you so desire.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
