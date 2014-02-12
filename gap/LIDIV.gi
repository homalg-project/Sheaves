#############################################################################
##
##  LIDIV.gi                                                 Sheaves package
##
##  Copyright 2012, Mohamed Barakat, University of Kaiserslautern
##
##  Logical Implications for DIVisors.
##
#############################################################################

##
## take care that we distinguish between objects and subobjects:
## some properties of a subobject might be those of the factor
## and not of the underlying object
##
InstallValue( LogicalImplicationsForDivisors,
        [ ## IsTorsionFree:
          
          [ IsZero,
            "implies", IsFree ],
          
          [ IsFree,
            "implies", IsStablyFree ],
          
          [ IsFree,
            "implies", IsSplitVectorBundle ],
          
          [ IsSplitVectorBundle,
            "implies", IsLocallyFree ],
          
          [ IsLocallyFree,
            "implies", IsReflexive ],
          
          ## see homalg/LIOBJ.gi for more implications
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForDivisors, IsDivisor );

####################################
#
# methods for properties:
#
####################################

## Saito's theorem states that for isolated singularities
## IsEulerHomogeneous is equivalent to IsQuasiHomogeneous
InstallMethod( IsEulerHomogeneous,
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

##
InstallMethod( IsFree,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return IsFree( DerMinusLog( D ) );
    
end );

##
InstallMethod( IsLocallyFree,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return IsLocallyFree( Sheafify( DerMinusLog( D ) ) );
    
end );

##
InstallMethod( IsSplitVectorBundle,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return IsSplitVectorBundle( Sheafify( DerMinusLog( D ) ) );
    
end );
