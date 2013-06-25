LoadPackage( "Sheaves" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
QQ := GradedRing( Q );

LoadPackage( "D-Modules" );

R := Q * "x,y";

R0 := LocalizeAtZero( R );

D1 := Divisor( "x^4+y^5" / R0 );
D2 := Divisor( "x^5+y^7" / R0 );
D0 := D1 + D2;
der := DerMinusLog( D0 );
Der := DerMinusLogInWeylAlgebra( D0 );
I := AssociatedOrderGradedModule( Der );
#ann2 := Annihilator( 2, 1, DefiningPolynomialOverWeylAlgebra( D0 ) );
#homalgIOMode( "D" );
#I := AssociatedOrderGradedModule( ann2 );
S := HomalgRing( I );

S0 := LocalizeAtZero( S );
I := S0 * I;

J := LeftSubmodule( "Dx,Dy", S0 );
L := Saturate( I, J );

K := LeftSubmodule( "x,y", S0 );
M := Saturate( L, K );

N := Saturate( L, M );
OnBasisOfPresentation( N );
d := AffineDegree( N );
Assert( 0, d = 24 );
