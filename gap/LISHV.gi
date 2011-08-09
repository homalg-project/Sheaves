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
            [ "RankOfObject",
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
            exchangeable_properties :=
                                    [
                                      [ "IsZero", "IsArtinian" ],
                                      "IsTorsion",
                                      ],
            exchangeable_true_properties :=
                                    [
                                      "IsPure",
                                      "IsReflexive",
                                      "IsTorsionFree",
                                      ],
            exchangeable_false_properties :=
                                    [
                                      ],
            exchangeable_attributes :=
                                    [
                                      "RankOfObject",
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
          
          ## see homalg/LIOBJ.gi for more implications
          
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
        IsCoherentSheafOnProjRep,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_properties,
        Concatenation( LISHV.intrinsic_properties, LISHV.intrinsic_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethodToPullTrueProperties(
        IsCoherentSheafOnProjRep,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_true_properties,
        Concatenation( LISHV.intrinsic_properties, LISHV.intrinsic_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethodToPullFalseProperties(
        IsCoherentSheafOnProjRep,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_false_properties,
        Concatenation( LISHV.intrinsic_properties, LISHV.intrinsic_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_properties,
        UnderlyingGradedModule );

##
InstallImmediateMethodToPushFalseProperties( Twitter,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_true_properties,
        UnderlyingGradedModule );

##
InstallImmediateMethodToPushTrueProperties( Twitter,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_false_properties,
        UnderlyingGradedModule );

##
InstallImmediateMethod( IsZero,
        IsCoherentSheafOnProjRep, 0,
        
  function( E )
    local M;
    
    M := UnderlyingGradedModule( E );
    
    if HasIsZero( M ) and not IsZero( M ) and HasTrivialArtinianSubmodule( M ) and not TrivialArtinianSubmodule( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsCoherentSheafOnProjRep,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_attributes,
        Concatenation( LISHV.intrinsic_properties, LISHV.intrinsic_attributes ),
        UnderlyingGradedModule );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsCoherentSheafOnProjRep,
        LISHV.exchangeable_attributes,
        UnderlyingGradedModule );

####################################
#
# methods for properties:
#
####################################

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
    local M, HM;
    
    M := UnderlyingGradedModule( E );
    
    HM := ModuleOfGlobalSections( M );
    
    AddANewPresentation( E, HM );
    
    return HM;
    
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
