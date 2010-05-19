package Text::TOC::InputHandler::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;

with 'Text::TOC::Role::InputHandler';

__PACKAGE__->meta()->make_immutable();

1;
