#############################################################################
##
##  LISHV.gi                    LISHV subpackage             Mohamed Barakat
##
##         LISHV = Logical Implications for homalg SHeaVes
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LISHV subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LISHV,
        rec(
            color := "\033[4;30;46m",
            intrinsic_attributes :=
            [ "RankOfSheaf",
              "Grade",
              "DegreeOfTorsionFreeness",
              "PurityFiltration",
              "CodegreeOfPurity",
              "CastelnuovoMumfordRegularity" ],
            intrinsic_properties :=
            [ "IsZero",
              "IsPure",
              "IsTorsion",
              "IsTorsionFree",
              "IsReflexive"
              ],
            pullable_properties :=
                                    [
                                      "IsZero",
                                      "IsTorsion",
#                                       "IsPure",
                                      "IsReflexive",
                                      "IsTorsionFree",
                                      ],
            pullable_attributes :=
                                    [
                                      ],
            pushable_properties :=
                                    [
                                      "IsTorsion",
                                      ],
            pushable_attributes :=
                                    [
                                      ]
            )
        );

##
InstallValue( LogicalImplicationsForHomalgSheaves,
        [ ## IsTorsionFree:
          
          [ IsZero,
            "implies", IsFree ],
          
          [ IsFree,
            "implies", IsStablyFree ],
          
          [ IsFree,
            "implies", IsDirectSumOfLineBundles ],
          
          [ IsDirectSumOfLineBundles,
            "implies", IsLocallyFree ],
          
          [ IsLocallyFree,
            "implies", IsReflexive ],
          
          [ IsReflexive,
            "implies", IsTorsionFree ],
          
          [ IsTorsionFree,
            "implies", IsPure ],
          
          ## IsTorsion:
          
          [ IsZero,
            "implies", IsTorsion ],
          
          ## IsZero:
          
          [ IsTorsion, "and", IsTorsionFree,
            "imply", IsZero ]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForHomalgSheaves, IsSheafOfModules );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsSheafOfModules,
        IsSheafOfModules,
        Concatenation( LISHV.pullable_properties, LISHV.pullable_attributes ),
        Concatenation( LISHV.intrinsic_properties, LISHV.intrinsic_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsSheafOfModules,
        Concatenation( LISHV.pushable_properties, LISHV.pushable_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethod( IsZero,
        IsSheafOfModules and HasGrade, 0,
        
  function( E )
    
    return Grade( E ) = infinity;
    
end );

##
InstallImmediateMethod( IsZero,
        IsSheafOfModules, -10,
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    if HasIsZero( M ) and IsZero( M ) then
        return true;
    fi;
    if HasIsArtinian( M ) and IsArtinian( M ) then
        return true;
    fi;
    if HasIsZero( M ) and not IsZero( M ) and HasTrivialArtinianSubmodule( M ) and not TrivialArtinianSubmodule( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules, 0,
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    if HasIsTorsion( M ) then
        return IsTorsion( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasRankOfSheaf, 0,
        
  function( M )
    
    return RankOfSheaf( M ) = 0;
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasTorsionFreeFactorEpi and HasIsZero, 0,
        
  function( M )
    local F;
    
    F := Range( TorsionFreeFactorEpi( M ) );
    
    if not IsZero( M ) and HasIsZero( F ) then
        if IsZero( F ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsion,
        IsSheafOfModules and HasGrade, 0,
        
  function( M )
    
    if Grade( M ) > 0 then
        return true;
    elif HasIsZero( M ) and not IsZero( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsTorsionFree,
        IsSheafOfModules and HasTorsionObjectEmb and HasIsZero, 0,
        
  function( M )
    local T;
    
    T := Source( TorsionObjectEmb( M ) );
    
    if not IsZero( M ) and HasIsZero( T ) then
        if IsZero( T ) then
            return true;
        else
            return false;
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsReflexive,
        IsSheafOfModules and IsTorsionFree and HasCodegreeOfPurity, 0,
        
  function( M )
    
    return CodegreeOfPurity( M ) = [ 0 ];
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RankOfSheaf,
        IsSheafOfModules, 0,
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    if HasRankOfObject( M ) then
        return RankOfObject( M );
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return IsZero( HomogeneousPartOverCoefficientsRing( CastelnuovoMumfordRegularity( M ), M ) );
    
end );

##
InstallMethod( IsTorsion,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return IsTorsion( M );
    
end );

##
InstallMethod( IsTorsionFree,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return IsArtinian( TorsionObject( M ) );
    
end );

##
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return IsTorsionFree( E ) and IsArtinian( Ext( 2, AuslanderDual( M ) ) );
    
end );

## FIXME: why can't HasCodegreeOfPurity be put in the header?
InstallMethod( IsReflexive,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    if HasCodegreeOfPurity( E ) then
        return IsTorsionFree( E ) and CodegreeOfPurity( E ) = [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( TorsionSubobject,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( F )
    local par, emb, tor;
    
    if HasIsTorsion( F ) and IsTorsion( F ) then
        return FullSubobject( F );
    fi;
    
    tor := ImageSubobject( KernelEmb( NatTrIdToHomHom_R( F ) ) );
    
    SetIsTorsion( tor, true );
    
    return tor;
    
end );

##
InstallMethod( TruncatedModuleOfGlobalSections,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return ModuleOfGlobalSections( M );
    
end );

##
InstallMethod( Support,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return Scheme( Annihilator( M ) );
    
end );

##
InstallMethod( RankOfSheaf,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    return RankOfObject( M );
    
end );

##
InstallMethod( Rank,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    return RankOfSheaf( E );
    
end );

##
InstallMethod( Grade,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M, depth;
    
    M := UnderlyingGradedModule( E );
    
    depth := Grade( M );
    
    if depth > DimensionOfAmbientSpace( E ) then
       return infinity;
    fi;
    
    return depth;
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsSheafOfModules ], 1001,
        
  function( E )
    
    if IsReflexive( E ) then
        return [ 0 ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( CodegreeOfPurity,
        "for sheaves",
        [ IsSheafOfModules ], 1001,
        
  function( E )
    
    if not IsTorsionFree( E ) and not IsTorsion( E ) then
        return infinity;
    fi;
    
    TryNextMethod( );
    
end );

##
## This can be done faster by just having a look at the (linear strand of the) Tate resolution
##
InstallMethod( CastelnuovoMumfordRegularity,
        "for coherent sheafs on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return CastelnuovoMumfordRegularity( TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( FullSubobject,
        "for homalg graded modules",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local subobject;
    
    subobject := ImageSubobject( SheafMorphism( FullSubobject( UnderlyingGradedModule( F ) )!.map_having_subobject_as_its_image, "create",  F) );
    
    SetEmbeddingInSuperObject( subobject, TheIdentityMorphism( F ) );
    
    return subobject;
    
end );

##
InstallMethod( ZeroSubobject,
        "for homalg graded modules",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local alpha, subobject;
    
    alpha := ZeroSubobject( UnderlyingGradedModule( F ) )!.map_having_subobject_as_its_image;
    
    subobject := UnderlyingSubobject( ImageObject( SheafMorphism( alpha, "create", F ) ) );
    
    SetIsZero( subobject, true );
    SetIsZero( UnderlyingObject( subobject ), true );
    
    return subobject;
    
end );
