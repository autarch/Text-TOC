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
