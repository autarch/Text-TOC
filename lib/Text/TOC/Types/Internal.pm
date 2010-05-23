package Text::TOC::Types::Internal;

use strict;
use warnings;
use namespace::autoclean;

use MooseX::Types -declare => [
    qw(
        Filter
        Node
        )
];

use MooseX::Types::Moose qw( CodeRef );

role_type Filter, { role => 'Text::TOC::Role::Filter' };

coerce Filter,
    from CodeRef,
    via { Text::TOC::Filter::Anon->new( code => $_ ) };

role_type Node, { role => 'Text::TOC::Role::Node' };

require Text::TOC::Filter::Anon;

1;
