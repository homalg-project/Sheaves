Read( "ProfileMainExample.g" );

Res := Resolution( W );
Res2 := ShortenResolution( W );
Resolution( W );
ByASmallerPresentation( W );

Hom( W, W );
TensorProduct( W, W );

Y := Hom( W );
iota := TorsionObjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionObject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );
