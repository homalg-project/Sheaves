#@exec LoadPackage( "Sheaves", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "Sheaves", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "MAGMA";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "MAGMA";;
gap> ReadPackage( "Sheaves", "examples/Curve_g=10_and_g^2_6-Sextic.g" );
 total:    1  28 132
--------------------
     0:    1   .   .
     1:    .  28 105
     2:    .   .  27
--------------------
degree:    0   1   2
true
gap> ReadPackage( "Sheaves", "examples/TwistedCubic.g" );
true
gap> ReadPackage( "Sheaves", "examples/FilteredByPurity.g" );
[x^2   x*z   0   -z*t   0   0   1   0   0]
[x*y   y*z   -z*t   0   0   0   0   0   0]
[0   0   x   -y   0   1   0   0   0]
[0   0   0   0   z*t^2   0   x   0   -1]
[0   0   0   0   x^2 - t^2   y   0   0   0]
[0   0   0   0   y*t   x   0   -1   0]
[0   0   0   0   0   z*t   -y   0   0]
[0   0   0   0   0   0   0   y - t   0]
[0   0   0   0   0   0   0   z   0]
[0   0   0   0   0   0   0   0   x]
[0   0   0   0   0   0   0   0   y]
[0   0   0   0   0   0   0   0   z]

Cokernel of the map

R^(1x12) --> R^(1x9), ( for R := Q[x,y,z,t] )

currently represented by the above matrix

(graded, degrees of generators: [ 0, 0, 0, 0, 0, 1, 2, 2, 3 ])
a sheaf modeled by the above graded module
true
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Singular";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Singular";;
#@fi
