## Edelman-Reiner's counterexample to a conjecture of Orlik
## it is not free but locally free on Proj

A := Tuples( [ 0, 1 ], 4 );

LoadPackage( "Sheaves" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
QQ := GradedRing( Q );

LoadPackage( "D-Modules" );

D := Divisor( A, QQ );

Assert( 0, not IsFree( D ) );
Assert( 0, IsLocallyFree( D ) );

R := HomalgRing( D );
R0 := LocalizeAtZero( R );

D0 := R0 * D;

m := DerMinusLogMap( D0 );
der := DerMinusLog( D0 );
f := DefiningPolynomialOverWeylAlgebra( D0 );
Der := DerMinusLogInWeylAlgebra( D0 );
quit;

#ann2 := Annihilator( 1, DefiningPolynomialOverWeylAlgebra( D0 ), 2 );
I := AssociatedOrderGradedModule( Der );
S := HomalgRing( I );

S0 := LocalizeAtZero( S );
I := S0 * I;

J := LeftSubmodule( "Dx1,Dx2,Dx3,Dx4", S0 );
L := Saturate( I, J );

K := LeftSubmodule( "x1,x2,x3,x4", S0 );
M := Saturate( L, K );

N := Saturate( L, M );
OnBasisOfPresentation( N );
d := AffineDegree( N );
