package ACME::ESP;
use vars qw( $VERSION @EXPORT );
BEGIN {
    $VERSION= 1.001_001;
    @EXPORT= 8x0 .oO ;
    require Exporter;
    *import= \&Exporter::import;
}

use strict;

sub oO
{
    my( $thought )= !@_ ? undef : join " ... ", @_;
    return bless \$thought, 'ACME::ESP::Scanner';
}

package ACME::ESP::Scanner;

use overload(
    '.' => \&scan,
    fallback => 0,
);

sub scan
{
    my( $scanner, $mind, $right )= @_;
    die "Attempt to read scanner's mind!\n"
        if  ! $right;
    $mind= \$_[1];
    my $secret= '';
    my( $p2, $rc, $f )=
        unpack "LLL", unpack "P12", pack "L", $mind;
    if(  5 == unpack "C", pack "V", $f  ) {
        my( $pv, $cur, $siz, $iv )=
            unpack "L4", unpack "P16", pack "L", $p2;
        $secret= unpack "P$iv", pack "L", $pv-$iv;
    }
    my $thought= $$scanner;
    if(  defined $thought  ) {
        # It is surprise how hard it can be to clear your mind
        my $surface= "$$mind";
        $$mind= undef;
        $$mind= $thought . $surface;
        substr( $$mind, 0, length($thought), "" );
    }
    return $secret;
}

'relax'
__END__

=head1 NAME

ACME::ESP - The power to implant and extract strings' thoughts.

=head1 SYNOPSIS

    #!/usr/bin/perl -l
    use ACME::ESP;

    my $string= "Nice hat.";

    # Implant a thought:
    $string.oO( "What an ugly hat!" );

    print $string;          # Prints "Nice hat."

    # Read a thought, leaving it in place:
    print $string.oO( );    # Prints "What an ugly hat!"

    # Read a throught, replacing it:
    print $string.oO( "Did I say that out loud?!" );
    # Prints "What an ugly hat!"

    # Empty their mind:
    print $string.oO( '' );
    # Prints "Did I say that out loud?!"

=head1 DESCRIPTION

ESP defies description.

=head1 GOTCHAS

Many operations on strings can destract them, removing the implanted
thought.

Some platforms are skeptical and interfere with the extraction of
stored thoughts.

=head1 AUTHOR

Tye McQueen, http://perlmonks.org/?node=tye

=head1 SEE ALSO

http://www.imdb.com/title/tt0087175/

=cut
