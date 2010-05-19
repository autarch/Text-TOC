package Text::TOC::Role::InputHandler;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

has _filter => (
    is   => 'ro',
    does => 'Text::TOC::Role::Filter',
);

1;
