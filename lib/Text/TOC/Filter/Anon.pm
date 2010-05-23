package Text::TOC::Filter::Anon;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::Types qw( CodeRef );

use Moose;

with 'Text::TOC::Role::Filter';

has code => (
    is       => 'ro',
    isa      => CodeRef,
    required => 1,
);

sub node_is_interesting {
    my $self = shift;
    my $node = shift;

    return $self->code()->($node);
}

__PACKAGE__->meta()->make_immutable();

1;
