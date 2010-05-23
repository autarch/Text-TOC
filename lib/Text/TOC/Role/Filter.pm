package Text::TOC::Role::Filter;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

requires 'node_is_interesting';


1;
