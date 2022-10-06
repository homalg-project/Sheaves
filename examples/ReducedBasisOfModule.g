ReadPackage( "Sheaves", "examples/MainExample.g" );

Hom( W, W );
WW := UnderlyingGradedModule( W );
Res := Resolution( W );
Res2 := ShortenResolution( W );
Resolution( W );
ByASmallerPresentation( W );
iota := TorsionObjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionObject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );
W2 := TensorProduct( W, W );
WW2 := TensorProduct( WW, WW );
