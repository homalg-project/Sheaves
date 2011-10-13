LoadPackage( "Sheaves" );

Q := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) );

R := Q * "a,b";

P1 := Proj( R );

d_uple_Embedding := function( d )
    local L;
    
    L := Sheafify( R^d );
    
    return InducedMorphismToProjectiveSpace( L );
    
end;

d := 3;

## the d-uple embedding of P^1 in P^d
f := d_uple_Embedding( d );

imP1 := ImageScheme( f );

Assert( 0, Dimension( imP1 ) = 1 );
Assert( 0, Degree( imP1 ) = d );
Assert( 0, ArithmeticGenus( imP1 ) = 0 );

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
