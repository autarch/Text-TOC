package Text::TOC::Role::InputHandler;

use strict;
use warnings;
use namespace::autoclean;

use Path::Class qw( file );

use Text::TOC::NodeList;
use Text::TOC::Types qw( ArrayRef File Filter HashRef Node );

use Moose::Role;

requires '_process_file';

has _files => (
    traits  => ['Array'],
    is      => 'bare',
    isa     => ArrayRef [File],
    default => sub { [] },
    handles => {
        _add_file => 'push',
        files     => 'elements',
    },
);

has _documents => (
    traits  => ['Hash'],
    is      => 'bare',
    isa     => HashRef,
    default => sub { {} },
    handles => {
        _add_document => 'set',
        document      => 'elements',
    },
);

has _filter => (
    is       => 'ro',
    isa      => Filter,
    coerce   => 1,
    init_arg => 'filter',
);

has node_list => (
    is       => 'ro',
    isa      => 'Text::TOC::NodeList',
    init_arg => undef,
    lazy     => 1,
    default  => sub { Text::TOC::NodeList->new() },
);

sub add_file {
    my $self = shift;
    my $file = file(shift);

    $self->_add_file($file);

    my $document = $self->_process_file($file);

    $self->_add_document( $file->stringify() => $document );

    return;
}

1;
