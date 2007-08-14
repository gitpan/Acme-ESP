package Acme::ESP;
use vars qw( $VERSION @EXPORT );
BEGIN {
    $VERSION= 1.002_001;
    @EXPORT= 8x0 .oO ;
    require Exporter;
    *import= \&Exporter::import;
}

use strict;

sub oO
{
    @_= map {
        my $i;
        eval{%$_||1}?(!%$_?():( $i= $_, join ".  ", map
            "$_: $$i{$_}", map substr("m;V",0,length) ^ $_, sort map
            $_ ^ substr("m;V",0,length), keys %$i ) . "." ) :
        eval{1+@$_}?(!@$_?(): join( "; ", @$_ ) ) : $_
    } @_;
    my( $thought )= !@_ ? undef : join " ... ", @_;
    return bless \$thought, 'Acme::ESP::Scanner';
}

sub O'o { [ shift,oO( @_ ) ]->[!$[] }

package Acme::ESP::Scanner;

use overload(
    '.' => \&scan,
    nomethod => \&explode,
);

my $openMind= 1<<25;
my $fmt= do {
    my $mind= "thoughts";
    $mind= \$mind;
    my( $p2, $rc, $f )=
        unpack "LLL", unpack "P12", pack "L", $mind;
    my $state= unpack "C", pack "V", $f;
    my $pre= 'x4';
    if(  $state == 4  ) {
        $openMind >>= 4;
        $pre= '';
    }
    my $last= "J";
    my $size= eval { length( pack "J", 1 ) };
    if(  ! defined $size  ) {
        $last= "L";
    } elsif(  4 < $size  &&  ! $pre  ) {
        $last= "x4J";
    }
    $pre . "L3" . $last;
};

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
            unpack $fmt, unpack "P24", pack "L", $p2;
        $pv= $p3
            if  $fmt =~ /^x/;
        $secret= unpack "P$iv", pack "L", $pv-$iv;
    }
    bless $scanner, 'Acme::ESP';
    my $thought= $$scanner;
    if(  defined $thought  ) {
        # It is surprising how hard it can be to clear your mind.
        # It'd be nice to do this less destructively.
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
    $string . o O ( "What an ugly hat!" );

    print $string;          # Prints "Nice hat."

    # Read a thought, leaving it in place:
    print $string.oO{ };    # Prints "What an ugly hat!"

    # Read a thought, replacing it:
    print $string.oO("Did I say that out loud?!");
    # Prints "What an ugly hat!"

    # Empty their mind:
    print $string . o O [ '' ];
    # Prints "Did I say that out loud?!"

=head1 DESCRIPTION

ESP defies description.

=head1 GOTCHAS

Many operations on strings can distract them, removing the implanted
thought.

Some platforms are skeptical and interfere with the extraction of
stored thoughts.

Pointed thoughts are not demonstrated above because of their quirks.
They never leave previous thoughts intact, may transform strangely
or be unreasonably literal, and (due to a Perl design flaw) may even
impact the surrounding environment (deleting files, etc.).

=head1 CONTRIBUTORS

Author: Tye McQueen, http://perlmonks.org/?node=tye

http://perlmonks.org/?node=Corion appears to have implanted the idea
into my brain.

http://perlmonks.org/?node=jZed inspired the initial test suite.

http://perlmonks.org/?node=Anno suggested the support for more drawn-out
thoughts.

=head1 SEE ALSO

http://www.imdb.com/title/tt0087175/ (but beware of the aggressive ads)

=cut
