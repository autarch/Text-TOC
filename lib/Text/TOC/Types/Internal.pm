package Text::TOC::Types::Internal;

use strict;
use warnings;
use namespace::autoclean;

use MooseX::Types -declare => [
    qw(
        Filter
        Node
        )
];

use MooseX::Types::Moose qw( CodeRef );

role_type Filter, { role => 'Text::TOC::Role::Filter' };

coerce Filter,
    from CodeRef,
    via { Text::TOC::Filter::Anon->new( code => $_ ) };

role_type Node, { role => 'Text::TOC::Role::Node' };

1;

# ABSTRACT: Defines types specific to Text::TOC

=pod

=head1 DESCRIPTION

This class defines several types used internally in Text::TOC.

=cut
