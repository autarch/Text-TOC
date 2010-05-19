package Text::TOC::Node::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;

with 'Text::TOC::Role::Node';

has contents => (

);


__PACKAGE__->meta()->make_immutable();

1;
