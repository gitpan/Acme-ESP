use Test qw( plan );

my $ok;
sub ok($;$$) {
    for(  &Test::ok(@_)  ) {
        $ok= 0
            if  ! $_;
        return $_;
    }
}
END {
    if(  defined $ok  &&  1 != $ok  ) {
        print STDERR "# fmt = '$Acme::ESP::fmt'\n"
            if  defined $Acme::ESP::fmt;
    }
}

BEGIN {
    if(  5.009 <= $]  &&  5.009 < 5.009_005  ) {
        print "1..0\n# This Perl experiment is dead. Long live 5.9.5+!\n";
        exit( 0 );
    }
    $^W= 0;
    my $mind= 'blank'; my $head= \$mind; $mind= pack "L", $head;
    if(  ! unpack "L", $mind  ) {
        print "1..0\n# Skip since this Perl can't pack a reference!\n";
        exit( 0 );
    }
    $^W= 1;
    plan(
        tests => 14,
        todo => [ ],
    );
    $ok= -1;

    require Acme::ESP;
    ok(1);
    Acme::ESP->import();
    ok(1);
}

$i= "person";
1 for $i.oO("I exist");
$Rene{descartes}++ if $i . o O ( );
ok( exists $Rene{descartes} );

ok(  $i .oO ( "Did I leave the oven on?" ), "I exist" );
ok(( $i . o O { } ), '/leave/' );
ok(( $i . o O [ ] ), '/oven/' );
ok(( $i . o O [ 1,2 ] ), '/on/' );
ok(( $i.oO{ 4..9 } ), '1; 2' );
ok(( $i.oO[ '' ] ), '/^8.*\.  6:/' );
ok(( $i . o O < oh wow > ), '' );
ok(( $i.oO< > ), 'oh ... wow' );
ok(  $i.oO( '' ), '' );
$i= 1;
ok( ! eval { 0 for $i..oO('Independent thought is fatal'); 1 } );
ok( ! eval { 0 for $i,oO('meta thought').oO("I don't like"); 1 } );
$ok &&= 1;
