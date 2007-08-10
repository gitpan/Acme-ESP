package Acme::ESP;
use vars qw( $VERSION @EXPORT );
BEGIN {
    $VERSION= 1.001_003;
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

package Acme::ESP::Scanner;

use overload(
    '.' => \&scan,
    nomethod => \&explode,
);

my $fluff= '';
my $openMind= 5;
{
    my $mind= "thoughts";
    $mind= \$mind;
    my( $p2, $rc, $f )=
        unpack "LLL", unpack "P12", pack "L", $mind;
    my $state= unpack "C", pack "V", $f;
    if(  $state == $openMind  ) {
        ++$openMind;
        $fluff= "x4";
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
    if(  $openMind == unpack "C", pack "V", $f  ) {
        my( $pv, $cur, $siz, $iv )=
            unpack $fluff."L4", unpack "P20", pack "L", $p2;
        $pv= $p3
            if  $fluff;
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
    print $string.oO( "Did I say that out loud?!" );
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

=head1 AUTHOR

Tye McQueen, http://perlmonks.org/?node=tye

=head1 SEE ALSO

http://www.imdb.com/title/tt0087175/ (but beware of the aggressive ads)

=cut
