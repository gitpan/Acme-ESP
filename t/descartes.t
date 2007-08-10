use Test qw( plan ok );

plan(
    tests => 6,
    todo => [ ],
);

require ACME::ESP;
ok(1);
ACME::ESP->import();
ok(1);

$i= "person";
1 for $i.oO("I exist");
$Rene{descartes}++ if $i.oO( );
ok( exists $Rene{descartes} );

ok( $i.oO("Did I leave the oven on?"), "I exist" );
ok( $i.oO(''), '/oven/' );
ok( $i.oO(''), '' );
