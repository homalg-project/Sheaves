LoadPackage( "Sheaves" );

Q := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) );

R := Q * "a,b";

P1 := Proj( R );

d_uple_Embedding := function( d )
    local L, f, imP1, M, S;
    
    L := Sheafify( R^d );
    
    f := InducedMorphismToProjectiveSpace( L );
    
    imP1 := ImageScheme( f );
    
    return imP1;
    
end;

d := 3;

## the d-uple embedding of P^1 in P^d
imP1 := d_uple_Embedding( d );

Assert( 0, Dimension( imP1 ) = 1 );
Assert( 0, Degree( imP1 ) = d );
Assert( 0, ArithmeticGenus( imP1 ) = 0 );

T := TateResolution( imP1, -3, 3 );
