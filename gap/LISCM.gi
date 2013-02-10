#############################################################################
##
##  LISCM.gi                    LISCM subpackage             Mohamed Barakat
##
##         LISCM = Logical Implications for SCheMes
##
##  Copyright 2008-2009, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for the LISCM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LISCM,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties :=
            [ "IsProjective",
	      "IsReduced",
              "IsSmooth" ],
            intrinsic_attributes :=
            [ "Genus",
              "DegreeAsSubscheme",
              "ArithmeticGenus",
              "Dimension" ]
            )
        );

##
InstallValue( LogicalImplicationsForSchemes,
        [ 
          
          
          ] );

####################################
#
# logical implications methods:
#
####################################

#InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForSchemes, IsScheme );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmpty,
        IsScheme and HasSingularLocus, 0,
        
  function( X )
    local sing;
    
    sing := SingularLocus( X );
    
    if HasIsEmpty( sing ) and not IsEmpty( sing ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsSmooth,
        IsScheme and HasSingularLocus, 0,
        
  function( X )
    local sing;
    
    sing := SingularLocus( X );
    
    if HasIsEmpty( sing ) then
        return IsEmpty( sing );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsEmpty,
        "LISCM: for schemes",
        [ IsScheme and IsAffine ],
        
  function( X )
    local J;
    
    J := VanishingIdeal( X );
    
    return J = HomalgRing( J );
    
end );

##
InstallMethod( IsEmpty,
        "LISCM: for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local J;
    
    J := VanishingIdeal( X );
    
    return AffineDimension( J ) = 0;
    
end );

##
InstallMethod( IsCohenMacaulay,
        "LISCM: for schemes",
        [ IsScheme ],
        
  function( X )
    local M;
    
    M := UnderlyingGradedModule( X );
    
    return IsCohenMacaulay( M );
    
end );

##
InstallMethod( IsSmooth,
        "LISCM: for schemes",
        [ IsScheme ],
        
  function( X )
    
    return IsEmpty( SingularLocus( X ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( DegreeAsSubscheme,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    if AffineDimension( UnderlyingGradedModule( X ) ) <= 0 then
        return 0;
    fi;
    
    return ProjectiveDegree( UnderlyingGradedModule( X ) );
    
end );

##
InstallMethod( Degree,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    return DegreeAsSubscheme( X );
    
end );

##
InstallMethod( Dimension,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    
    return AffineDimension( UnderlyingGradedModule( X ) ) - 1;
    
end );

##
InstallMethod( ArithmeticGenus,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local P_0;
    
    P_0 := ConstantTermOfHilbertPolynomial( UnderlyingGradedModule( X ) );
    
    return (-1)^Dimension( X ) * ( P_0 - 1 );
    
end );

##
InstallMethod( IrreducibleComponents,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingGradedModule( X ) );
    
    return List( primary_decomposition, J -> Scheme( J[1] ) );
    
end );

##
InstallMethod( ReducedScheme,
        "for schemes",
        [ IsProjSchemeRep ],
        
  function( X )
    local primary_decomposition;
    
    primary_decomposition := PrimaryDecomposition( UnderlyingGradedModule( X ) );
    
    return Scheme( Intersect( List( primary_decomposition, J -> J[2] ) ) );
    
end );

