package MaxMind::DB::Common;
{
  $MaxMind::DB::Common::VERSION = '0.3.0'; # TRIAL
}

use strict;
use warnings;

use constant {
    LEFT_RECORD                 => 0,
    RIGHT_RECORD                => 1,
    DATA_SECTION_SEPARATOR_SIZE => 16,
};

use Exporter qw( import );

our @EXPORT_OK = qw( LEFT_RECORD RIGHT_RECORD DATA_SECTION_SEPARATOR_SIZE );

1;

# ABSTRACT: Code shared by the MaxMind::DB:Reader and MaxMind::DB::Writer modules

__END__

=pod

=head1 NAME

MaxMind::DB::Common - Code shared by the MaxMind::DB:Reader and MaxMind::DB::Writer modules

=head1 VERSION

version 0.3.0

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <autarch@urth.org>

=item *

Olaf Alders <olaf@wundercounter.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by MaxMind, Inc..

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
