A := [
      [ 1, 0, 0 ],
      [ 0, 1, 0 ],
      [ 0, 0, 1 ],
      [ 1, 1, 1 ],
      [ 1, 1, -1 ],
      [ 1, -1, 1 ],
      [ 1, -1, -1 ],
      ];


LoadPackage( "Sheaves" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
QQ := GradedRing( Q );

LoadPackage( "D-Modules" );

D := Divisor( A, QQ );

Assert( 0, IsFree( D ) );

R := HomalgRing( D );
R0 := LocalizeAtZero( R );

D0 := R0 * D;

m := DerMinusLogMap( D0 );
der := DerMinusLog( D0 );
f := DefiningPolynomialOverWeylAlgebra( D0 );
Der := DerMinusLogInWeylAlgebra( D0 );
