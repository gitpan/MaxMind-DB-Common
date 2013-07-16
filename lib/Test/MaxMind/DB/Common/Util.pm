package Test::MaxMind::DB::Common::Util;
{
  $Test::MaxMind::DB::Common::Util::VERSION = '0.031001';
}
BEGIN {
  $Test::MaxMind::DB::Common::Util::AUTHORITY = 'cpan:TJMATHER';
}

use strict;
use warnings;

use Exporter qw( import );

our @EXPORT_OK = qw( standard_test_metadata );

sub standard_test_metadata {
    return (
        database_type => 'Test',
        languages     => [ 'en', 'zh' ],
        description   => {
            en => 'Test Database',
            zh => 'Test Database Chinese',
        },
    );
}

1;
