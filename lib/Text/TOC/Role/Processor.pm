package Text::TOC::Role::Processor;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

has tree => (
    is  => 'ro',
    isa => 'Text::TOC::Tree',
);

has input_handler => (
    is      => 'ro',
    does    => 'Text::TOC::Role::InputHandler',
    lazy    => 1,
    builder => '_build_input_handler',
);

has output_handler => (
    is      => 'ro',
    does    => 'Text::TOC::Role::OutputHandler',
    lazy    => 1,
    builder => '_build_output_handler',
);

sub add_document {
    my $self = shift;
    my $doc = shift;

    for my $node ( $self->input_handler()->nodes_for_document($doc) ) {
        $self->tree->add_node($node);
        $self->output_handler()->add_anchor_to_node( $node, $doc );
    }
}

sub content {
    ...
}

sub content_with_toc {
    ...
}

1;
