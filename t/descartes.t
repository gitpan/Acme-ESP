use Test qw( plan ok );

BEGIN {
    $^W= 0;
    my $mind= 'blank'; $mind= \$mind; $mind= pack "L", $mind;
    if(  ! unpack "L", $mind  ) {
        print "1..0\n# Skip since this Perl can't pack a reference!\n";
        exit( 0 );
    }
    $^W= 1;
    plan(
        tests => 14,
        todo => [ ],
    );

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
