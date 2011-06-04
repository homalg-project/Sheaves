LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x,y,z,t" );

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z*t,       \
x^3*z,x^2*z^2,0,         \
x^4,  x^3*z,  0,         \
0,    0,      x*y,       \
0,    0,      x^2*z      \
]", 5, 3, S );

LoadPackage( "GradedModules" );

LoadPackage( "Sheaves" );

wmor := GradedMap( wmat, "free", "free", "left", S );

IsMorphism( wmor );

wmor := SheafMorphism( wmor, "create", "create" );

IsMorphism( wmor );

W := Sheafify( LeftPresentationWithDegrees( wmat ) );

