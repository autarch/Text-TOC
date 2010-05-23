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
