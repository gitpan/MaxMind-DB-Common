
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/MaxMind/DB/Common.pm',
    'lib/MaxMind/DB/Metadata.pm',
    'lib/MaxMind/DB/Role/Debugs.pm',
    'lib/MaxMind/DB/Types.pm',
    'lib/Test/MaxMind/DB/Common/Data.pm',
    'lib/Test/MaxMind/DB/Common/Util.pm'
);

notabs_ok($_) foreach @files;
done_testing;
