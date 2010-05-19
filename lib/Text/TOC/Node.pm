package Text::TOC::Node;

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;

has type => (

);

__PACKAGE__->meta()->make_immutable();

1;
