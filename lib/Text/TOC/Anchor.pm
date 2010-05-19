package Text::TOC::Anchor;

use strict;
use warnings;
use namespace::autoclean;

use Tree::Simple;

use Moose;
use MooseX::StrictConstructor;

has anchor => (
    is  => 'ro',
    isa => Str,
);

__PACKAGE__->meta()->make_immutable();

1;
