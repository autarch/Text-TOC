package Text::TOC::Role::OutputHandler;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

requires qw( process_node_list );

1;
