LoadPackage( "Sheaves" );

Q := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) );

R := Q * "a,b,c";

d := 2;

d_uple_Embedding := function( d )
    local L, f, Veronese, M, S;
    
    L := Sheafify( R^d );
    
    f := InducedMorphismToProjectiveSpace( L );
    
    Veronese := ImageScheme( f );
    
    M := UnderlyingGradedModule( Veronese );
    
    S := HomalgRing( M );
    
    KoszulDualRing( S, List( [ 0 .. Length( Indeterminates( S ) ) - 1 ], e -> Concatenation( "e", String( e ) ) ) );
    
    return Veronese;
    
end;

Veronese := d_uple_Embedding( d );

Degree( Veronese );
ArithmeticGenus( Veronese );

T := TateResolution( Veronese, -3, 3 );
