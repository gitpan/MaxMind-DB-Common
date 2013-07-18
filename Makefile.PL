
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Code shared by the DB reader and writer modules",
  "AUTHOR" => "Dave Rolsky <autarch\@urth.org>, Olaf Alders <olaf\@wundercounter.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "MaxMind-DB-Common",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "MaxMind::DB::Common",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper::Concise" => 0,
    "DateTime" => 0,
    "Exporter" => 0,
    "List::AllUtils" => 0,
    "Math::Int128" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "MooX::StrictConstructor" => 0,
    "Scalar::Util" => 0,
    "Sub::Quote" => 0,
    "autodie" => 0,
    "constant" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.88"
  },
  "VERSION" => "0.031002",
  "test" => {
    "TESTS" => "t/*.t t/MaxMind/DB/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



