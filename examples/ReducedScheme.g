LoadPackage( "Sheaves" );

R := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x,y" );

S := Scheme( GradedLeftSubmodule( "x^3*(x-y)^2", R ) );

irrS := IrreducibleComponents( S );

Sred := ReducedScheme( S );

irrSred := IrreducibleComponents( Sred );
