#@exec LoadPackage( "Sheaves", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "Sheaves", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
gap> ReadPackage( "Sheaves", "examples/Curve_g=5_and_g^1_3-Quintic.g" );
 total:  1 5
------------
     0:  1 .
     1:  . 3
     2:  . 2
------------
degree:  0 1
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=5_and_g^1_4-Sextic.g" );
 total:  1 3
------------
     0:  1 .
     1:  . 3
------------
degree:  0 1
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=6_and_g^1_3-Sextic.g" );
 total:   1  9 16
-----------------
     0:   1  .  .
     1:   .  6  8
     2:   .  3  8
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=6_and_g^1_4-Sextic.g" );
 total:   1  6 10
-----------------
     0:   1  .  .
     1:   .  6  5
     2:   .  .  5
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=6_and_g^2_5-Quintic.g" );
 total:   1  9 16
-----------------
     0:   1  .  .
     1:   .  6  8
     2:   .  3  8
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=7_and_g^1_3-Sextic.g" );
 total:   1 14 35
-----------------
     0:   1  .  .
     1:   . 10 20
     2:   .  4 15
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=7_and_g^1_4-Septic.g" );
 total:   1 10 19
-----------------
     0:   1  .  .
     1:   . 10 16
     2:   .  .  3
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=7_and_g^1_5-Septic.g" );
 total:   1 10 16
-----------------
     0:   1  .  .
     1:   . 10 16
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=7_and_g^2_6-Sextic.g" );
 total:   1 10 25
-----------------
     0:   1  .  .
     1:   . 10 16
     2:   .  .  9
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=8_and_g^1_3-Septic.g" );
 total:   1 20 64
-----------------
     0:   1  .  .
     1:   . 15 40
     2:   .  5 24
-----------------
degree:   0  1  2
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=8_and_g^1_4-Septic.g" );
 total:   1 15 39 50
--------------------
     0:   1  .  .  .
     1:   . 15 35 25
     2:   .  .  4 25
--------------------
degree:   0  1  2  3
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=8_and_g^1_5-Septic.g" );
 total:   1 15 35 42
--------------------
     0:   1  .  .  .
     1:   . 15 35 21
     2:   .  .  . 21
--------------------
degree:   0  1  2  3
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=8_and_g^2_6-Sextic.g" );
 total:   1 15 49 70
--------------------
     0:   1  .  .  .
     1:   . 15 35 35
     2:   .  . 14 35
--------------------
degree:   0  1  2  3
true
gap> ReadPackage( "Sheaves", "examples/Curve_g=9_and_g^2_6-Sextic.g" );
 total:   1 21 84
-----------------
     0:   1  .  .
     1:   . 21 64
     2:   .  . 20
-----------------
degree:   0  1  2
true
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
gap> ReadPackage( "Sheaves", "examples/d-uple_Embedding_of_P1.g" );
true
gap> ReadPackage( "Sheaves", "examples/Pullback_d-uple_Embedding_of_P1.g" );
true
gap> ReadPackage( "Sheaves", "examples/RationalQuartic.g" );
true
gap> ReadPackage( "Sheaves", "examples/Pullback_RationalQuartic.g" );
true
gap> ReadPackage( "Sheaves", "examples/Triangle.g" );
true
gap> ReadPackage( "Sheaves", "examples/FilteredByPurity.g" );
0,  0,  x,   -y,  0,      1,  0, 0,  0, 
x*y,y*z,-z*t,0,   0,      0,  0, 0,  0, 
x^2,x*z,0,   -z*t,0,      0,  1, 0,  0, 
0,  0,  0,   0,   0,      z*t,-y,0,  0, 
0,  0,  0,   0,   y*t,    x,  0, -1, 0, 
0,  0,  0,   0,   x^2-t^2,y,  0, 0,  0, 
0,  0,  0,   0,   z*t^2,  0,  x, 0,  -1,
0,  0,  0,   0,   0,      0,  0, z,  0, 
0,  0,  0,   0,   0,      0,  0, y-t,0, 
0,  0,  0,   0,   0,      0,  0, 0,  z, 
0,  0,  0,   0,   0,      0,  0, 0,  y, 
0,  0,  0,   0,   0,      0,  0, 0,  x  

Cokernel of the map

R^(1x12) --> R^(1x9), ( for R := Q[x,y,z,t] )

currently represented by the above matrix

(graded, degrees of generators: [ 0, 0, 0, 0, 0, 1, 2, 2, 3 ])
a sheaf modeled by the above graded module
true
#@fi
