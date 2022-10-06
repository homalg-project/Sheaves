LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

LoadPackage( "GradedRingForHomalg" );

R := GradedRing( R );

LoadPackage( "Sheaves" );

## no singular points (a smooth curve)
p := [  ];

## are s distinct points in P2
s := Length( p );

## with defining ideals
p := List( p, q -> GradedRightSubmodule( q, R ) );

## and multiplicities
r := [ ];

## and degree
d := 5;

## a random plane curve of degree d with s ordinary singularities
C := RandomProjectivePlaneCurve( d, R * 1 );

## the genus g of the curve
g := Genus( C );

## the canonical sheaf of C as a sheaf on the ambient projective plane
omega := CanonicalSheafOnAmbientSpace( C );

## the induced morphism in the projective space P^{g-1}
f := InducedMorphismToProjectiveSpace( omega );

## the image of P2
imP2 := ImageScheme( f );

## the module underlying the structure sheaf O_P2, as a module over
## the homogeneous coordinate ring of ambient projective space P^{g-1}
imOP2 := UnderlyingGradedModule( imP2 );

## its Betti diagram
bettiP2 := BettiTable( Resolution( Int( g / 2 ) - 1, imOP2 ) );

## the canonical model of C
imC := ImageScheme( f, C );

## the module underlying the structure sheaf O_C, as a module over
## the homogeneous coordinate ring of ambient projective space P^{g-1}
imOC := UnderlyingGradedModule( imC );

## its Betti diagram
bettiC := BettiTable( Resolution( Int( g / 2 ) - 1, imOC ) );

Display( bettiC );

Assert( 0,
        MatrixOfDiagram( bettiC ) =
        [ [ 1, 0, 0 ],
          [ 0, 6, 8 ],
          [ 0, 3, 8 ] ] );
