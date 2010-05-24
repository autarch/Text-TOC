package Text::TOC::Role::Node;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Util::TypeConstraints qw( class_type );
use Text::TOC::Types qw( File Str );

use MooseX::Role::Parameterized;

has type => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has anchor_name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has source_file => (
    is       => 'ro',
    isa      => File,
    required => 1,
);

parameter contents_type => (
    is       => 'ro',
    isa      => Str | class_type('Moose::Meta::TypeConstraint'),
    required => 1,
);

role {
    my $p = shift;

    has contents => (
        is       => 'ro',
        isa      => $p->contents_type(),
        required => 1,
    );
};

1;

# ABSTRACT: A role for nodes

=pod

=head1 DESCRIPTION

This role defines the API and partial implementation for nodes. A node
represents an item of interest from the original document that will be
included in the table of contents.

=head1 PARAMETERS

This role is parameterzed, and requires a single parameter:

=over 4

=item * contents_type

This is the type of the contents attribute. It should be passed as either a
string or a type constraint object.

=back

=head1 ATTRIBUTES

This role provides the following attributes:

=over 4

=item * type

This is a string. What this represents will depend on the class which consumes
this role.

=item * anchor_name

The name of the anchor associated with this node.

=item * source_file

A L<Path::Class::File> object representing the source file for the node.

=item * contents

The contents of the node. Exactly what this is depends on the class consuming
this role.

=back

=cut
