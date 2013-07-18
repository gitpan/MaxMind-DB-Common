package Test::MaxMind::DB::Common::Data;
{
  $Test::MaxMind::DB::Common::Data::VERSION = '0.031002';
}
BEGIN {
  $Test::MaxMind::DB::Common::Data::AUTHORITY = 'cpan:TJMATHER';
}

use strict;
use warnings;

use Exporter qw( import );
use Math::Int128 qw( uint128 );

our @EXPORT_OK = qw( test_cases_for );

sub test_cases_for {
    my $type = shift;

    my $method = '_' . $type;

    return __PACKAGE__->$method(@_);
}

sub _array {
    my @one_value = (
        ['Foo'] => [
            0b00000001,
            0b00000100,
            (
                # Foo
                0b01000011,
                0b01000110, 0b01101111, 0b01101111
            )
        ],
    );

    my @two_values = (
        [
            'Foo',
            "\x{4eba}",
        ] => [
            0b00000010,
            0b00000100,
            (
                # Foo
                0b01000011,
                0b01000110, 0b01101111, 0b01101111
            ),
            (
                # \x{4eba}
                0b01000011,
                0b11100100, 0b10111010, 0b10111010
            ),
        ],
    );

    return [
        [] => [ 0b00000000, 0b00000100 ],
        @one_value,
        @two_values,
    ];
}

sub _bytes {
    my @bytes = (
        q{}   => [0b10000000],
        '1'   => [ 0b10000001, ord('1') ],
        '123' => [ 0b10000011, map { ord($_) } qw( 1 2 3 ) ],
        '123456789012345678901234567' => [
            0b10011011,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 )
        ],
        '1234567890123456789012345678' => [
            0b10011100,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 )
        ],
        '12345678901234567890123456789' => [
            0b10011101, 0b00000000,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 )
        ],
        '123456789012345678901234567890' => [
            0b10011101, 0b00000001,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 )
        ],
    );

    my $bytes_500 = 'x' x 500;
    push @bytes, $bytes_500 => [
        0b10011110, 0b00000000, 0b11010111,
        map { ord($_) } split //, $bytes_500
    ];

    my $bytes_2000 = 'x' x 2000;
    push @bytes, $bytes_2000 => [
        0b10011110, 0b00000110, 0b10110011,
        map { ord($_) } split //, $bytes_2000
    ];

    my $bytes_70000 = 'x' x 70000;
    push @bytes, $bytes_70000 => [
        0b10011111, 0b00000000, 0b00010000, 0b01010011,
        map { ord($_) } split //, $bytes_70000
    ];

    return \@bytes;
}

sub _double {
    return [
        0.0 => [
            0b01101000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000
        ],
        0.5 => [
            0b01101000,
            0b00111111, 0b11100000, 0b00000000, 0b00000000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000
        ],
        3.14159265359 => [
            0b01101000,
            0b01000000, 0b00001001, 0b00100001, 0b11111011,
            0b01010100, 0b01000100, 0b00101110, 0b11101010
        ],
        123 => [
            0b01101000,
            0b01000000, 0b01011110, 0b11000000, 0b00000000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000
        ],
        1073741824.12457 => [
            0b01101000,
            0b01000001, 0b11010000, 0b00000000, 0b00000000,
            0b00000000, 0b00000111, 0b11111000, 0b11110100
        ],
        -0.5 => [
            0b01101000,
            0b10111111, 0b11100000, 0b00000000, 0b00000000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000
        ],
        -3.14159265359 => [
            0b01101000,
            0b11000000, 0b00001001, 0b00100001, 0b11111011,
            0b01010100, 0b01000100, 0b00101110, 0b11101010
        ],
        -1073741824.12457 => [
            0b01101000,
            0b11000001, 0b11010000, 0b00000000, 0b00000000,
            0b00000000, 0b00000111, 0b11111000, 0b11110100
        ],
    ];
}

sub _float {
    return [
        0.0 => [
            0b00000100, 0b00001000,
            0b00000000, 0b00000000, 0b00000000, 0b00000000
        ],
        1.0 => [
            0b00000100, 0b00001000,
            0b00111111, 0b10000000, 0b00000000, 0b00000000
        ],
        1.1 => [
            0b00000100, 0b00001000,
            0b00111111, 0b10001100, 0b11001100, 0b11001101
        ],
        3.14 => [
            0b00000100, 0b00001000,
            0b01000000, 0b01001000, 0b11110101, 0b11000011
        ],
        9999.99 => [
            0b00000100, 0b00001000,
            0b01000110, 0b00011100, 0b00111111, 0b11110110
        ],
        -1.0 => [
            0b00000100, 0b00001000,
            0b10111111, 0b10000000, 0b00000000, 0b00000000
        ],
        -1.1 => [
            0b00000100, 0b00001000,
            0b10111111, 0b10001100, 0b11001100, 0b11001101
        ],
        -3.14 => [
            0b00000100, 0b00001000,
            0b11000000, 0b01001000, 0b11110101, 0b11000011
        ],
        -9999.99 => [
            0b00000100, 0b00001000,
            0b11000110, 0b00011100, 0b00111111, 0b11110110
        ],
    ];
}

sub _int32 {
    my $max = 2**31 - 1;

    return [
        0  => [ 0b00000000, 0b00000001 ],
        -1 => [
            0b00000100, 0b00000001,
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ],
        ( 2**8 - 1 ) => [
            0b00000001, 0b00000001,
            0b11111111,
        ],
        -1 * ( 2**8 - 1 ) => [
            0b00000100, 0b00000001,
            0b11111111, 0b11111111, 0b11111111, 0b00000001,
        ],
        500 => [
            0b00000010, 0b00000001,
            0b00000001, 0b11110100
        ],
        -500 => [
            0b00000100, 0b00000001,
            0b11111111, 0b11111111, 0b11111110, 0b00001100,
        ],
        ( 2**16 - 1 ) => [
            0b00000010, 0b00000001,
            0b11111111, 0b11111111
        ],
        -1 * ( 2**16 - 1 ) => [
            0b00000100, 0b00000001,
            0b11111111, 0b11111111, 0b00000000, 0b00000001,
        ],
        ( 2**24 - 1 ) => [
            0b00000011, 0b00000001,
            0b11111111, 0b11111111, 0b11111111
        ],
        -1 * ( 2**24 - 1 ) => [
            0b00000100, 0b00000001,
            0b11111111, 0b00000000, 0b00000000, 0b00000001,
        ],
        $max => [
            0b00000100, 0b00000001,
            0b01111111, 0b11111111, 0b11111111, 0b11111111
        ],
        -1 * $max => [
            0b00000100, 0b00000001,
            0b10000000, 0b00000000, 0b00000000, 0b00000001,
        ]
    ];
}

sub _map {
    my @one_key = (
        { 'en' => 'Foo' } => [
            0b11100001,
            (
                # en
                0b01000010,
                0b01100101, 0b01101110
            ),
            (
                # Foo
                0b01000011,
                0b01000110, 0b01101111, 0b01101111
            )
        ],
    );

    my @two_keys = (
        {
            'en' => 'Foo',
            'zh' => "\x{4eba}",
        } => [
            0b11100010,
            (
                # en
                0b01000010,
                0b01100101, 0b01101110
            ),
            (
                # Foo
                0b01000011,
                0b01000110, 0b01101111, 0b01101111
            ),
            (
                # zh
                0b01000010,
                0b01111010, 0b01101000
            ),
            (
                # \x{4eba}
                0b01000011,
                0b11100100, 0b10111010, 0b10111010
            ),
        ],
    );

    my @nested = (
        { name => { en => 'Bar', zh => "\x{4ebb}" } } => [
            0b11100001,
            (
                # name
                0b01000100,
                0b01101110, 0b01100001, 0b01101101, 0b01100101
            ),
            0b11100010,
            (
                # en
                0b01000010,
                0b01100101, 0b01101110
            ),
            (
                # Bar
                0b01000011,
                0b01000010, 0b01100001, 0b01110010
            ),
            (
                # zh
                0b01000010,
                0b01111010, 0b01101000
            ),
            (
                # \x{4ebb}
                0b01000011,
                0b11100100, 0b10111010, 0b10111011
            ),
        ],
    );

    my @guess = (
        {
            languages => [ 'en', 'zh' ],
        } => [
            0b11100001,
            (    # languages
                0b01001001,
                0b01101100, 0b01100001, 0b01101110, 0b01100111, 0b01110101,
                0b01100001, 0b01100111, 0b01100101, 0b01110011
            ),
            (
                # array
                0b00000010,
                0b00000100,
                (
                    # en
                    0b01000010,
                    0b01100101, 0b01101110
                ),
                (
                    # zh
                    0b01000010,
                    0b01111010, 0b01101000
                ),
            ),
        ],
    );

    return [
        {} => [0b11100000],
        @one_key,
        @two_keys,
        @nested,
        @guess,
    ];
}

sub _pointer {
    return [
        0 => [
            0b00100000,
            0b00000000
        ],
        5 => [
            0b00100000,
            0b00000101
        ],
        10 => [
            0b00100000,
            0b00001010
        ],
        ( 2**10 ) - 1 => [
            0b00100011,
            0b11111111,
        ],
        3017 => [
            0b00101000,
            0b00000011, 0b11001001
        ],
        2**19 - 5 => [
            0b00101111,
            0b11110111, 0b11111011
        ],
        ( 2**19 + 2**11 ) - 1 => [
            0b00101111,
            0b11111111, 0b11111111
        ],
        2**27 - 2 => [
            0b00110111,
            0b11110111, 0b11110111, 0b11111110
        ],
        ( 2**27 + 2**19 + 2**11 ) - 1 => [
            0b00110111,
            0b11111111, 0b11111111, 0b11111111
        ],
        ( 2**32 - 1 ) => [
            0b00111000,
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ],
    ];
}

sub _uint128 {
    my @uint128 = (
        uint128(0)   => [ 0b00000000, 0b00000011 ],
        uint128(500) => [
            0b00000010, 0b00000011,
            0b00000001, 0b11110100
        ],
        uint128(10872) => [
            0b00000010, 0b00000011,
            0b00101010, 0b01111000
        ],
    );

    for my $power ( 1 .. 16 ) {
        my $key = uint128(2)**( 8 * $power ) - uint128(1);

        my $value = [
            $power, 0b00000011,
            (0b11111111) x $power
        ];

        push @uint128, $key => $value;
    }

    return \@uint128;
}

sub _uint64 {
    my @uint64 = (
        uint128(0)   => [ 0b00000000, 0b00000010 ],
        uint128(500) => [
            0b00000010, 0b00000010,
            0b00000001, 0b11110100
        ],
        uint128(10872) => [
            0b00000010, 0b00000010,
            0b00101010, 0b01111000
        ],
    );

    for my $power ( 1 .. 8 ) {
        my $key = uint128(2)**( 8 * $power ) - uint128(1);

        my $value = [
            $power, 0b00000010,
            (0b11111111) x $power
        ];

        push @uint64, $key => $value;
    }

    return \@uint64;
}

sub _uint32 {
    my $max = 2**32 - 1;

    return [
        0            => [0b11000000],
        ( 2**8 - 1 ) => [
            0b11000001,
            0b11111111,
        ],
        500 => [
            0b11000010,
            0b00000001, 0b11110100
        ],
        10872 => [
            0b11000010,
            0b00101010, 0b01111000
        ],
        ( 2**16 - 1 ) => [
            0b11000010,
            0b11111111, 0b11111111
        ],
        ( 2**24 - 1 ) => [
            0b11000011,
            0b11111111, 0b11111111, 0b11111111
        ],
        $max => [
            0b11000100,
            0b11111111, 0b11111111, 0b11111111, 0b11111111
        ],
    ];
}

sub _uint16 {
    my $max = 2**16 - 1;

    return [
        0            => [0b10100000],
        ( 2**8 - 1 ) => [
            0b10100001,
            0b11111111,
        ],
        500 => [
            0b10100010,
            0b00000001, 0b11110100
        ],
        10872 => [
            0b10100010,
            0b00101010, 0b01111000
        ],
        $max => [
            0b10100010,
            0b11111111, 0b11111111,
        ],
    ];
}

sub _utf8_string {
    shift;
    my %p = @_;

    my @string = (
        q{}        => [0b01000000],
        '1'        => [ 0b01000001, ord('1') ],
        "\x{4eba}" => [
            0b01000011,
            0b11100100, 0b10111010, 0b10111010
        ],
        '123' => [ 0b01000011, map { ord($_) } qw( 1 2 3 ) ],
        '123456789012345678901234567' => [
            0b01011011,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 )
        ],
        '1234567890123456789012345678' => [
            0b01011100,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 )
        ],
        '12345678901234567890123456789' => [
            0b01011101, 0b00000000,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 )
        ],
        '123456789012345678901234567890' => [
            0b01011101, 0b00000001,
            map { ord($_) }
                qw( 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 )
        ],
    );

    my $string_500 = 'x' x 500;
    push @string, $string_500 => [
        0b01011110, 0b00000000, 0b11010111,
        map { ord($_) } split //, $string_500
    ];

    my $string_2000 = 'x' x 2000;
    push @string, $string_2000 => [
        0b01011110, 0b00000110, 0b10110011,
        map { ord($_) } split //, $string_2000
    ];

    my $string_70000 = 'x' x 70000;
    push @string, $string_70000 => [
        0b01011111, 0b00000000, 0b00010000, 0b01010011,
        map { ord($_) } split //, $string_70000
    ];

    return \@string;
}

sub _boolean {
    return [
        0 => [
            0b00000000, 0b00000111,
        ],
        1 => [
            0b00000001, 0b00000111,
        ],
    ];
}

1;
