package Text::TOC::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::InputHandler::HTML;
use Text::TOC::OutputHandler::HTML;
use Text::TOC::Types qw( Filter );

use Moose;
use MooseX::StrictConstructor;

has input_handler => (
    is       => 'ro',
    isa      => 'Text::TOC::InputHandler::HTML',
    init_arg => undef,
    lazy     => 1,
    builder  => '_build_input_handler',
    handles  => [ 'add_file', 'documents' ],
);

has filter => (
    is     => 'rw',
    writer => '_set_filter',
);

has output_handler => (
    is       => 'ro',
    isa      => 'Text::TOC::OutputHandler::HTML',
    init_arg => undef,
    lazy     => 1,
    builder  => '_build_output_handler',
);

has _link_generator => (
    is       => 'rw',
    init_arg => 'link_generator',
    writer   => '_set_link_generator',
);

has _style => (
    is       => 'ro',
    init_arg => 'style',
);

my $single_filter = sub { $_[0]->tagName() =~ /^h[2-4]$/i };
my $multi_filter  = sub { $_[0]->tagName() =~ /^h[1-4]$/i };

sub BUILD {
    my $self = shift;
    my $p    = shift;

    my $filter;
    if ( exists $p->{filter} && !ref $p->{filter} ) {
        $filter
            = $p->{filter} eq 'single' ? $single_filter
            : $p->{filter} eq 'multi'  ? $multi_filter
            :                            die "Invalid filter ($p->{filter})";
    }

    if ( !exists $p->{filter} ) {
        $filter = $single_filter;
    }

    $self->_set_filter($filter) if $filter;

    return;
}

sub _build_input_handler {
    my $self = shift;
    return Text::TOC::InputHandler::HTML->new( filter => $self->filter() );
}

sub _build_output_handler {
    my $self = shift;

    my %p;
    $p{link_generator} = $self->_link_generator()
        if $self->_link_generator();

    $p{style} = $self->_style()
        if $self->_style();

    return Text::TOC::OutputHandler::HTML->new(%p);
}

sub toc {
    my $self = shift;

    return $self->output_handler()
        ->process_node_list( $self->input_handler()->node_list() );
}

__PACKAGE__->meta()->make_immutable();

1;
