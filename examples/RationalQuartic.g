## [Eis, Exercise 18.8]:
LoadPackage( "Sheaves" );

Q := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) );

R := Q * "a,b";

P1 := Proj( R );

O4 := Sheafify( R^4 );

H0 := GlobalSections( O4 );

phi := GradedMap( CertainRows( HomalgIdentityMatrix( 5, Q ), [ 1, 2, 4, 5 ] ), "free", H0 );

Assert( 0, IsMorphism( phi ) );

V := ImageObject( phi );

L := AsLinearSystem( V );

f := InducedMorphismToProjectiveSpace( L );

imP1 := ImageScheme( f );

Assert( 0, Dimension( imP1 ) = 1 );
Assert( 0, Degree( imP1 ) = 4 );
Assert( 0, ArithmeticGenus( imP1 ) = 0 );

S := HomalgRing( imP1 );
m := MaximalGradedLeftIdeal( S );

M := UnderlyingGradedModule( imP1 );

## [Eis, pp. 466]:
## quite generally, the homogeneous coordinate ring of a variety
## in an incomplete embedding is never Cohen-Macaulay.
Assert( 0, not IsCohenMacaulay( M ) );
Assert( 0, not IsCohenMacaulay( imP1 ) );

tate := TateResolution( imP1, -3, 3 );

T := HomalgRing( imP1 );

S := AmbientRing( T );

m := MaximalGradedLeftIdeal( S );
k := 1 * S / m;

phi := UnderlyingRingMap( f );

I_X := DefiningIdeal( T );

O_X := UnderlyingGradedModule( imP1 );

cotangentPn := SyzygiesObject( 2, k );

tangentPn := GradedHom( cotangentPn );

cotangentPnX := O_X * cotangentPn;

tangentPnX := O_X * tangentPn;

conormal := I_X / I_X^2;

normal := GradedHom( conormal, O_X );
