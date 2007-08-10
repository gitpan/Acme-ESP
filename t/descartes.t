use Test qw( plan ok );

plan(
    tests => 7,
    todo => [ ],
);

require Acme::ESP;
ok(1);
Acme::ESP->import();
ok(1);

$i= "person";
1 for $i.oO("I exist");
$Rene{descartes}++ if $i.oO( );
ok( exists $Rene{descartes} );

ok( $i.oO("Did I leave the oven on?"), "I exist" );
ok( $i.oO(''), '/oven/' );
ok( $i.oO(''), '' );
$i= 1;
ok( ! eval { 0 for $i..oO('Independent thought is fatal'); 1 } );
