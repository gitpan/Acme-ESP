package Acme::ESP;
use vars qw( $VERSION @EXPORT );
BEGIN {
    $VERSION= 1.001_006;
    @EXPORT= 8x0 .oO ;
    require Exporter;
    *import= \&Exporter::import;
}

use strict;

sub oO
{
    my( $thought )= !@_ ? undef : join " ... ", @_;
    return bless \$thought, 'Acme::ESP::Scanner';
}

sub O'o { shift; oO( @_ ) }

package Acme::ESP::Scanner;

use overload(
    '.' => \&scan,
    nomethod => \&explode,
);

my $openMind= 1<<21;
my $fmt= 'LLLL';
{
    my $mind= "thoughts";
    $mind= \$mind;
    my( $p2, $rc, $f )=
        unpack "LLL", unpack "P12", pack "L", $mind;
    my $state= unpack "C", pack "V", $f;
    $fmt= "LLLJ"    # Why does "LLJJ" work in cygwin?
        if  eval { pack "J", 1; 1 };
    if(  $state == 5  ) {
        $openMind <<= 4;
        $fmt= "x4" . $fmt;
    }
}

sub scan
{
    my( $scanner, $mind, $right )= @_;
    die "Attempt to read scanner's mind!\n"
        if  ! $right;
    $mind= \$_[1];
    my $secret= '';
    my( $p2, $rc, $f, $p3 )=
        unpack "L4", unpack "P16", pack "L", $mind;
    if(  $openMind & $f  ) {
        my( $pv, $cur, $siz, $iv )=
            unpack $fmt, unpack "P32", pack "L", $p2;
        $pv= $p3
            if  $fmt =~ /x/;
        $secret= unpack "P$iv", pack "L", $pv-$iv;
    }
    bless $scanner, 'Acme::ESP';
    my $thought= $$scanner;
    if(  defined $thought  ) {
        # It is surprising how hard it can be to clear your mind
        my $surface= "$$mind";
        $$mind= undef;
        $$mind= $thought . $surface;
        substr( $$mind, 0, length($thought), "" );
    }
    return $secret;
}

sub explode
{
    die "Acme::ESP mis-used.\n";
}

'relax'
__END__

=head1 NAME

Acme::ESP - The power to implant and extract strings' thoughts.

=head1 SYNOPSIS

    #!/usr/bin/perl -l
    use Acme::ESP;

    my $string= "Nice hat.";

    # Implant a thought:
    $string.oO( "What an ugly hat!" );

    print $string;          # Prints "Nice hat."

    # Read a thought, leaving it in place:
    print $string.oO( );    # Prints "What an ugly hat!"

    # Read a thought, replacing it:
    print $string . o O ( "Did I say that out loud?!" );
    # Prints "What an ugly hat!"

    # Empty their mind:
    print $string.oO( '' );
    # Prints "Did I say that out loud?!"

=head1 DESCRIPTION

ESP defies description.

=head1 GOTCHAS

Many operations on strings can distract them, removing the implanted
thought.

Some platforms are skeptical and interfere with the extraction of
stored thoughts.

=head1 CONTRIBUTORS

Author: Tye McQueen, http://perlmonks.org/?node=tye

http://perlmonks.org/?node=Corion appears to have implanted the idea
into my brain.

http://perlmonks.org/?node=jZed inspired much of the test suite.

http://perlmonks.org/?node=Anno suggested the support for more drawn-out
thoughts.

=head1 SEE ALSO

http://www.imdb.com/title/tt0087175/ (but beware of the aggressive ads)

=cut
