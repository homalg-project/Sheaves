LoadPackage( "Sheaves" );

R := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w" );

## the intersection of the two conics Q1 := x*y-z*w, Q2 := x^2-y*w
## is the twisted cubic and a line
CL := GradedRightSubmodule( "x*y-z*w,x^2-y*w", R );

## the line
L := GradedRightSubmodule( "x, w", R );

## remove the line and obtain the twisted cubic
C := Saturate( CL, L );

## the *projective* twisted cubic C is a set-theoretic CI
## but *not* an ideal-theoretic CI, contrary to the affine one
J := RightSubmodule( "x^2-y*w, y*(y^2-x*z)+z*(z*w-x*y)", R );
Assert( 0, C = RadicalSubobject( J ) );

CL := Scheme( CL );
C := Scheme( C );

Assert( 0, Degree( C ) = 3 );
Assert( 0, Dimension( C ) = 1 );
Assert( 0, ArithmeticGenus( C ) = 0 );

S := HomalgRing( C );
m := MaximalGradedLeftIdeal( S );

M := UnderlyingGradedModule( C );

Assert( 0, IsCohenMacaulay( M ) );
Assert( 0, IsCohenMacaulay( C ) );
