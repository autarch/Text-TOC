package Text::TOC::Role::OutputHandler;

use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;

requires qw( insert_toc insert_anchor );

1;
