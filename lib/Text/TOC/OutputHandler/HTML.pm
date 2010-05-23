package Text::TOC::OutputHandler::HTML;

use strict;
use warnings;
use namespace::autoclean;

use Text::TOC::Types qw( CodeRef Str );

use Moose;
use MooseX::StrictConstructor;

with 'Text::TOC::Role::OutputHandler';

has _toc => (
    is       => 'ro',
    isa      => 'HTML::DOM',
    init_arg => undef,
    lazy     => 1,
    default  => sub { HTML::DOM->new() },
);

has _link_generator => (
    is       => 'ro',
    isa      => CodeRef,
    init_arg => 'link_generator',
    default  => sub {
        sub { $_[0]->_default_link( $_[1] ) }
    },
);

has _style => (
    is       => 'ro',
    isa      => Str,
    init_arg => 'style',
    default  => 'unordered',
);


sub process_node_list {
    my $self      = shift;
    my $node_list = shift;

    my $toc = $self->_toc();

    my $list_tag = $self->_style() eq 'unordered' ? 'ul' : 'ol';

    my $list = $toc->createElement($list_tag);
    $toc->appendChild($list);

    my @lists = $list;

    my $level = 1;
    my $last_node;

    for my $node ( $node_list->nodes() ) {
        $self->_insert_anchor($node);

        my $diff = $self->_node_level_difference( $node, $last_node );
        if ( $diff > 0 ) {
            for ( 1..$diff ) {
                my $new_list = $toc->createElement($list_tag);
                my $last_li  = $lists[-1]->lastChild();

                if ( ! $last_li ) {
                    $last_li = $toc->createElement('li');
                    $lists[-1]->appendChild($last_li);
                }

                $last_li->appendChild($new_list);

                push @lists, $new_list;
            }
        }
        elsif ( $diff < 0 ) {
            pop @lists for 1..abs($diff);
        }

        my $li   = $toc->createElement('li');
        my $link = $toc->createElement('a');
        $link->setAttribute(
            href => $self->_link_generator->( $self, $node ) );
        $link->appendChild( $toc->createTextNode( $node->contents()->as_text() ) );

        $li->appendChild($link);

        $lists[-1]->appendChild($li);

        $last_node = $node;
    }

    return $toc;
}

sub _node_level_difference {
    my $self      = shift;
    my $this_node = shift;
    my $last_node = shift;

    return 0 unless defined $last_node;

    return $self->_node_level($last_node) - $self->_node_level($this_node);
}

{
    my %node_levels = (
        h1 => 7,
        h2 => 6,
        h3 => 5,
        h4 => 4,
        h5 => 3,
        h6 => 2,
    );

    sub _node_level {
        my $self = shift;
        my $node = shift;

        return $node_levels{ $node->type() } || 1;
    }
}

sub _default_link {
    my $self = shift;
    my $node = shift;

    return q{#} . $node->anchor_name();
}

sub _insert_anchor {
    my $self = shift;
    my $node = shift;

    my $domlet = $node->contents();
    my $anchor = $domlet->ownerDocument()->createElement('a');
    $anchor->setAttribute( name => $node->anchor_name() );

    $domlet->insertBefore( $anchor, $domlet->firstChild() );

    return;
}

sub add_node_to_toc {
    my $self = shift;
    my $node = shift;


}

__PACKAGE__->meta()->make_immutable();

1;
