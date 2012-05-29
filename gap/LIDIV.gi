#############################################################################
##
##  LIDIV.gi                                                 Sheaves package
##
##  Copyright 2012, Mohamed Barakat, University of Kaiserslautern
##
##  Logical Implications for DIVisors.
##
#############################################################################

####################################
#
# methods for properties:
#
####################################

## Saito's theorem
InstallMethod( IsQuasiHomogeneous,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local f, R, var, n, varvec, map;
    
    f := DefiningPolynomial( D );
    
    R := HomalgRing( f );
    
    if not ( HasIsLocal( R ) and IsLocal( R ) ) then
        Error( "the ring is not known to be local" );
    fi;
    
    var := Indeterminates( R );
    
    n := Length( var );
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    f := HomalgMatrix( [ f ], 1, 1, R );
    
    map := Diff( Involution( varvec ), f );
    
    return IsZero( DecideZeroRows( f, map ) );
    
end );
