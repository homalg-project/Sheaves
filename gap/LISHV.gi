#############################################################################
##
##  LISHV.gi                    LISHV subpackage             Mohamed Barakat
##
##         LISHV = Logical Implications for homalg SHeaVes
##
##  Copyright 2008-2009, Mohamed Barakat, University of Kaiserslautern
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
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_subobjects_and_ideals :=
            [ 
              "IsFree",
              "IsDirectSumOfLineBundles",
              "IsLocallyFree",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_factors_modulo_ideals :=
            [ 
              ],
            
            intrinsic_properties_specific_not_shared_with_subobjects :=
            [ 
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    ~.intrinsic_properties_specific_shared_with_subobjects_and_ideals,
                    ~.intrinsic_properties_specific_shared_with_factors_modulo_ideals ),
            
            ## needed to define intrinsic_properties below
            intrinsic_properties_specific :=
            Concatenation(
                    ~.intrinsic_properties_specific_not_shared_with_subobjects,
                    ~.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in Subsheaf.gi
            intrinsic_properties_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_subobjects_and_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_properties_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_factors_modulo_ideals,
                    ~.intrinsic_properties_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in Subsheaf.gi
            intrinsic_properties_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_properties :=
            Concatenation(
                    LIOBJ.intrinsic_properties,
                    ~.intrinsic_properties_specific ),
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_subobjects_and_ideals :=
            [ 
              "CastelnuovoMumfordRegularity",
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_factors_modulo_ideals :=
            [ 
              ],
            
            intrinsic_attributes_specific_not_shared_with_subobjects :=
            [ 
              ],
            
            ## used in a InstallLogicalImplicationsForHomalgSubobjects call below
            intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    ~.intrinsic_attributes_specific_shared_with_subobjects_and_ideals,
                    ~.intrinsic_attributes_specific_shared_with_factors_modulo_ideals ),
            
            ## needed to define intrinsic_attributes below
            intrinsic_attributes_specific :=
            Concatenation(
                    ~.intrinsic_attributes_specific_not_shared_with_subobjects,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in Subsheaf.gi
            intrinsic_attributes_shared_with_subobjects_and_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_subobjects_and_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_and_ideals ),
            
            ##
            intrinsic_attributes_shared_with_factors_modulo_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_factors_modulo_ideals,
                    ~.intrinsic_attributes_specific_shared_with_factors_modulo_ideals ),
            
            ## needed for MatchPropertiesAndAttributes in Subsheaf.gi
            intrinsic_attributes_shared_with_subobjects_which_are_not_ideals :=
            Concatenation(
                    LIOBJ.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals,
                    ~.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals ),
            
            ## needed for UpdateObjectsByMorphism
            intrinsic_attributes :=
            Concatenation(
                    LIOBJ.intrinsic_attributes,
                    ~.intrinsic_attributes_specific ),
            
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
              "HilbertPolynomial",
              "ElementOfGrothendieckGroup",
              "ChernPolynomial",
              "ChernCharacter",
              ],
            
            exchangeable_attributes_sheaf_of_rings :=
            [ 
              "RankOfObject",
              "HilbertPolynomial",
              "ElementOfGrothendieckGroup",
              "ChernPolynomial",
              "ChernCharacter",
              ],
            
            )
        );

##
## take care that we distinguish between objects and subobjects:
## some properties of a subobject might be those of the factor
## and not of the underlying object
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

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_properties_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_properties_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_properties_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_attributes_specific_shared_with_subobjects_which_are_not_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and NotConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_attributes_specific_shared_with_subobjects_and_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and ConstructedAsAnIdeal,
        HasEmbeddingInSuperObject,
        UnderlyingObject );

InstallLogicalImplicationsForHomalgSubobjects(
        List( LISHV.intrinsic_attributes_specific_shared_with_factors_modulo_ideals, ValueGlobal ),
        IsCoherentSheafOnProjRep and ConstructedAsAnIdeal,
        HasFactorObject,
        FactorObject );

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
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsSheafOfRingsOnSchemeRep,
        IsSheafOfRingsOnSchemeRep,
        LISHV.exchangeable_attributes_sheaf_of_rings,
        LISHV.exchangeable_attributes_sheaf_of_rings,
        AsModuleOverStructureSheafOfAmbientSpace );

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

##
InstallMethod( IsLocallyFree,
        "for coherent sheaves on Proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, S, n, omega, i;
    
    M := UnderlyingGradedModule( F );
    
    S := HomalgRing( M );
    
    if not ( HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) and
             Set( WeightsOfIndeterminates( S ) ) = [ 1 ] ) then
        TryNextMethod( );
    fi;
    
    n := Length( Indeterminates( S ) ) - 1;
    
    omega := S^-(n+1);
    
    ## Serre's vector bundle criterion
    for i in [ 1 .. n ] do
        ## Serre's duality
        if not IsArtinian( GradedExt( i, M, omega ) ) then
            return false;
        fi;
    od;
    
    return true;
    
end );

##
InstallMethod( IsDirectSumOfLineBundles,
        "for coherent sheaves on Proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, S, n, omega, i;
    
    M := UnderlyingGradedModule( F );
    
    S := HomalgRing( M );
    
    if not ( HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) and
             Set( WeightsOfIndeterminates( S ) ) = [ 1 ] ) then
        TryNextMethod( );
    fi;
    
    n := Length( Indeterminates( S ) ) - 1;
    
    omega := S^-(n+1);
    
    ## Horrocks' splitting
    for i in [ 1 .. n - 1 ] do
        ## Serre's duality
        if not IsZero( GradedExt( i, M, omega ) ) then
            return false;
        fi;
    od;
    
    ## Serre's duality
    if not IsArtinian( GradedExt( n, M, omega ) ) then
        return false;
    fi;
    
    return true;
    
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
