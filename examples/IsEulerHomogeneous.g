LoadPackage( "Sheaves" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
QQ := GradedRing( Q );

LoadPackage( "D-Modules" );

R := Q * "x,y";

R0 := LocalizeAtZero( R );

D1 := Divisor( "x^4+y^5" / R0 );
D2 := Divisor( "x^5+y^7" / R0 );
Assert( 0, not IsEulerHomogeneous( D1 + D2 ) );

D0 := Divisor( "x+x^4*y^6+x^5*y+x*y^11+y^4+y" / R0 );
Assert( 0, IsEulerHomogeneous( D0 ) );
