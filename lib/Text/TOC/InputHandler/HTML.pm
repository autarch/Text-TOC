package Text::TOC::InputHandler::HTML;

use strict;
use warnings;
use namespace::autoclean;

use HTML::DOM;
use HTML::Entities qw( encode_entities );
use Text::TOC::Node::HTML;
use Text::TOC::Types qw( Int );

use Moose;
use MooseX::StrictConstructor;

with 'Text::TOC::Role::InputHandler';

has _counter => (
    traits  => ['Counter'],
    is      => 'ro',
    isa     => Int,
    default => 0,
    handles => { _inc_counter => 'inc' },
);

__PACKAGE__->meta()->make_immutable();

sub _process_file {
    my $self    = shift;
    my $file    = shift;
    my $content = shift;

    my $dom = HTML::DOM->new();
    $dom->write($content);

    $self->_walk_nodes( $dom->body() || $dom, $file );

    return $dom;
}

sub _walk_nodes {
    my $self   = shift;
    my $parent = shift;
    my $file   = shift;

    for my $node ( grep { $_->isa('HTML::DOM::Element') }
        $parent->childNodes() ) {

        if ( $self->_filter()->node_is_interesting($node) ) {
            $self->_save_node( $node, $file );
        }
        else {
            $self->_walk_nodes( $node, $file );
        }
    }

    return;
}

sub _save_node {
    my $self = shift;
    my $node = shift;
    my $file = shift;

    my $wrapped = Text::TOC::Node::HTML->new(
        type        => lc $node->tagName(),
        contents    => $node,
        anchor_name => $self->_anchor_name($node),
        source_file => $file,
    );

    $self->_add_node($wrapped);

    return;
}

sub _anchor_name {
    my $self   = shift;
    my $domlet = shift;

    my $text_contents = $domlet->as_text();

    $text_contents =~ s/\s+/_/g;
    # These are the only characters allowed in a name according to the HTML
    # spec.
    $text_contents =~ s/[^A-Za-z0-9-_:.]//g;

    my $name = encode_entities($text_contents) . q{-} . $self->_counter();
    # Anchors must begin with a letter.
    $name = 'A-' . $name unless $name =~ /^[A-Za-z]/;

    $self->_inc_counter();

    return $name;
}

1;

# ABSTRACT: Implements an input handler for HTML documents

=pod

=head1 DESCRIPTION

This class processes an HTML document and finds nodes which should be included
in the table of contents.

It has no end-user facing parts at the moment.

=head1 ROLES

This class does the L<Text::TOC::Role::InputHandler> role.

=cut
