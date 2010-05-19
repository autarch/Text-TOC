package Text::TOC::NodeList;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::Node;

use Moose;
use MooseX::StrictConstructor;

has _nodes => (
    traits  => ['Array'],
    is      => 'ro',
    isa     => ArrayRef ['Text::TOC::Node'],
    handles => {
        nodes    => 'elements',
        add_node => 'push',
    },
);

__PACKAGE__->meta()->make_immutable();

1;
