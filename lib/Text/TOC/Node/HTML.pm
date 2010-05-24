package Text::TOC::Node::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use MooseX::StrictConstructor;
use Moose::Util::TypeConstraints qw( class_type );

with 'Text::TOC::Role::Node' =>
    { contents_type => class_type('HTML::DOM::Node') };

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Represents a node in an HTML document

=pod

=head1 DESCRIPTION

This class represents a node from an HTML document which will be included in
the table of contents.

=head1 METHODS

This class implements the following methods:

=head2 Text::TOC::Node::HTML->new( ... )

The constructor accepts the following arguments:

=over 4

=item * type

This is expected to be an HTML tag name, like "h2" or "img".

=item * anchor_name

The name of the anchor associated with this node.

=item * source_file

A L<Path::Class::File> object representing the source file for the node.

=item * contents

An L<HTML::DOM::Node> object representing the node and its contents.

=back

=head2 $node->type()

=head2 $node->anchor_name()

=head2 $node->source_file()

=head2 $node->contents()

Returns the value as passed to the constructor.

=head1 ROLES

This class does the L<Text::TOC::Role::Node> role.

=cut
