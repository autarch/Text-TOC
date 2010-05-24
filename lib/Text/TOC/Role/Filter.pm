package Text::TOC::Role::Filter;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

requires 'node_is_interesting';

1;

# ABSTRACT: A role for node filters

=head1 DESCRIPTION

This role defines the API for node filters.

=head1 REQUIRED METHODS

This role requires one method:

=head2 $filter->node_is_interesting($node)

This method should take an object which does the L<Text::TOC::Role::Node> role
and return true or false. If it returns true, the node will be included in the
table of contents.

=cut
