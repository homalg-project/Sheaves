#############################################################################
##
##  LISHVMOR.gi                               LISHVMOR subpackage of Sheaves
##
##         LISHV = Logical Implications for homalg SHeaVes
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

InstallValue( LISHVMOR,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIGrHOM.intrinsic_properties,
            intrinsic_attributes := LIGrHOM.intrinsic_attributes,
            exchangeable_properties :=
                                    [
                                      "IsMorphism",
                                      "IsMonomorphism",
                                      [ "IsGeneralizedEpimorphism", [ "IsGeneralizedMorphism" ] ],
                                      [ "IsGeneralizedMonomorphism", [ "IsGeneralizedMorphism" ] ],
                                      [ "IsGeneralizedIsomorphism", [ "IsGeneralizedMorphism" ] ],
                                      ],
            exchangeable_true_properties :=
                                    [
                                      "IsZero",
                                      "IsOne",
                                      "IsGeneralizedMorphism",
                                      "IsEpimorphism",
                                      "IsSplitMonomorphism",
                                      "IsSplitEpimorphism",
                                      "IsIsomorphism",
                                      ],
            exchangeable_false_properties :=
                                    [
                                      ],
            exchangeable_attributes :=
                                    [
                                      ],
            )
        );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsMorphismOfCoherentSheavesOnProjRep,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_properties,
        Concatenation( LISHVMOR.intrinsic_properties, LISHVMOR.intrinsic_attributes ),
        UnderlyingGradedMap );

##
InstallImmediateMethodToPullTrueProperties(
        IsMorphismOfCoherentSheavesOnProjRep,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_true_properties,
        Concatenation( LISHVMOR.intrinsic_properties, LISHVMOR.intrinsic_attributes ),
        UnderlyingGradedMap );

##
InstallImmediateMethodToPullFalseProperties(
        IsMorphismOfCoherentSheavesOnProjRep,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_false_properties,
        Concatenation( LISHVMOR.intrinsic_properties, LISHVMOR.intrinsic_attributes ),
        UnderlyingGradedMap );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_properties,
        UnderlyingGradedMap );

##
InstallImmediateMethodToPushFalseProperties( Twitter,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_true_properties,
        UnderlyingGradedMap );

##
InstallImmediateMethodToPushTrueProperties( Twitter,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_false_properties,
        UnderlyingGradedMap );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsMorphismOfCoherentSheavesOnProjRep,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_attributes,
        Concatenation( LISHVMOR.intrinsic_properties, LISHVMOR.intrinsic_attributes ),
        UnderlyingGradedMap );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMorphismOfCoherentSheavesOnProjRep,
        LISHVMOR.exchangeable_attributes,
        UnderlyingGradedMap );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( KernelSubobject,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local ker, emb, source, target;
    
    source := Source( phi );
    
    ker := KernelSubobject( UnderlyingGradedMap( phi ) );
    
    emb := EmbeddingInSuperObject( ker );
    
    emb := SheafMorphism( emb, "create", Source( phi ) );
    
    Assert( 3, IsMorphism( emb ) );
    SetIsMorphism( emb, true );
    
    ker := ImageSubobject( emb );
    
    target := Range( phi );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetCokernelEpi( ker, phi );
    fi;
    
    if HasRankOfObject( source ) and HasRankOfObject( target ) then
        if RankOfObject( target ) = 0 then
            SetRankOfObject( ker, RankOfObject( source ) );
        fi;
    fi;
    
    return ker;
    
end );

##
InstallMethod( TruncatedModuleOfGlobalSections,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local psi, result;
    
    Assert( 0, not HasMorphismAid( phi ) );
    
    psi := UnderlyingGradedMap( phi );
    
    result := ModuleOfGlobalSections( psi );
    
    return result;
    
end );

##
InstallMethod( AdditiveInverse,
        "for homalg graded maps",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local psi;
    
    psi := SheafMorphism( -UnderlyingGradedMap( phi ), Source( phi ), Range( phi ) );
    
    SetPropertiesOfAdditiveInverse( psi, phi );
    
    return psi;
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsZero( ImageObject( phi ) );
    
end );