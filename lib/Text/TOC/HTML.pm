package Text::TOC::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::InputHandler::HTML;
use Text::TOC::OutputHandler::HTML;

use Moose;
use MooseX::StrictConstructor;

sub _build_input_handler {
    return Text::TOC::InputHandler::HTML->new();
}

sub _build_output_handler {
    return Text::TOC::OutputHandler::HTML->new();
}

__PACKAGE__->meta()->make_immutable();

1;
