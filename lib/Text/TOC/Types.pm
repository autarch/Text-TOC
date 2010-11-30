package Text::TOC::Types;

use strict;
use warnings;

use base 'MooseX::Types::Combine';

__PACKAGE__->provide_types_from(
    qw( Text::TOC::Types::Internal
        MooseX::Types::Moose
        MooseX::Types::Path::Class
        )
);

require Text::TOC::Filter::Anon;

1;

# ABSTRACT: Provides types for use in Text::TOC

=pod

=head1 DESCRIPTION

This class exports the types from L<Text::TOC::Types::Internal>,
L<MooseX::Types::Moose> , and L<MooseX::Types::Path::Class>.

=cut
