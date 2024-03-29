package MaxMind::DB::Role::Debugs;
$MaxMind::DB::Role::Debugs::VERSION = '0.031003';
use strict;
use warnings;
use namespace::autoclean;
use autodie;

use Moo::Role;

sub _debug_newline {
    warn "\n";
}

sub _debug_binary {
    my $self   = shift;
    my $label  = shift;
    my $binary = shift;

    my $msg = "$label: ";

    if ( defined $binary ) {
        $msg .= join q{ }, map { sprintf( "%08b", ord($_) ) } split //,
            $binary;
    }
    else {
        $msg .= '<undef>';
    }

    warn "$msg\n";
}

sub _debug_string {
    my $self   = shift;
    my $label  = shift;
    my $string = shift;

    $string = '<undef>'
        unless defined $string;

    warn "$label: $string\n";
}

sub _debug_sprintf {
    my $self = shift;

    warn sprintf( shift() . "\n", @_ );
}

sub _debug_structure {
    my $self      = shift;
    my $label     = shift;
    my $structure = shift;

    require Data::Dumper::Concise;
    warn "$label: \n";
    my $dumped = Data::Dumper::Concise::Dumper($structure);

    $dumped =~ s/^/  /mg;

    warn $dumped;
}

sub _debug_message {
    my $self = shift;
    my $msg  = shift;

    warn "$msg\n";
}

1;
