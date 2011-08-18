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

C := ImageScheme( f );

Assert( 0, Dimension( C ) = 1 );
Assert( 0, Degree( C ) = 4 );
Assert( 0, ArithmeticGenus( C ) = 0 );

S := HomalgRing( C );
m := MaximalGradedLeftIdeal( S );
