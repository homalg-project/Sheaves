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

T := HomalgRing( imP1 );
m := MaximalGradedLeftIdeal( T );

O_X := UnderlyingGradedModule( imP1 );

## [Eis, pp. 466]:
## quite generally, the homogeneous coordinate ring of a variety
## in an incomplete embedding is never Cohen-Macaulay.
Assert( 0, not IsCohenMacaulay( O_X ) );
Assert( 0, not IsCohenMacaulay( imP1 ) );

tate := TateResolution( imP1, -3, 3 );

S := AmbientRing( T );

m := MaximalGradedLeftIdeal( S );
k := 1 * S / m;

phi := UnderlyingRingMap( f );

I_X := DefiningIdeal( T );

cotangentPn := SyzygiesObject( 2, k );

tangentPn := GradedHom( cotangentPn );

cotangentPnX := O_X * cotangentPn;

tangentPnX := O_X * tangentPn;

conormal := I_X / I_X^2;

normal := GradedHom( conormal, O_X );

pb := Pullback( phi, conormal );

ByASmallerPresentation( pb );

Assert( 0, CastelnuovoMumfordRegularity( pb ) = 15 );

betti := BettiTable( TateResolution( pb, 1, 10 ) );

Assert( 0, MatrixOfDiagram( betti ) =
        [ [ 12, 10, 8, 6, 4, 2, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 2, 4, 6, 8 ] ] );

Assert( 0, CastelnuovoMumfordRegularityOfSheafification( pb ) = 7 );

pb := StandardModule( pb );

Assert( 0, IsFree( pb ) );
Assert( 0, DegreesOfGenerators( pb ) = [ 7, 7 ] );
