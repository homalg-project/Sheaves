LoadPackage( "Sheaves" );

R := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w" );

## the intersection of the two conics Q1 := y*w-x^2, Q2 := z*w^2-x^3
## is the twisted cubic and a line
CL := GradedRightSubmodule( "y*w-x^2, z*w^2-x^3", R );

## the line
L := GradedRightSubmodule( "x, w", R );

## remove the line and obtain the twisted cubic
C := Saturate( CL, L );

CL := Scheme( CL );
C := Scheme( C );

Assert( 0, Degree( C ) = 3 );
Assert( 0, Dimension( C ) = 1 );
Assert( 0, ArithmeticGenus( C ) = 0 );
