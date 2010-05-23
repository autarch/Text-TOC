package Text::TOC::NodeList;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::Types qw( ArrayRef Node );

use Moose;
use MooseX::StrictConstructor;

has _nodes => (
    traits  => ['Array'],
    is      => 'bare',
    isa     => ArrayRef [Node],
    default => sub { [] },
    handles => {
        nodes    => 'elements',
        add_node => 'push',
    },
);

__PACKAGE__->meta()->make_immutable();

1;
