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
            pullable_properties :=
                                    [ "IsZero",
                                      "IsOne",
                                      "IsGeneralizedMorphism",
                                      "IsGeneralizedEpimorphism",
                                      "IsGeneralizedMonomorphism",
                                      "IsGeneralizedIsomorphism",
                                      "IsMonomorphism",
                                      "IsEpimorphism",
                                      "IsSplitMonomorphism",
                                      "IsSplitEpimorphism",
                                      "IsIsomorphism"
                                      ],
            pullable_attributes :=
                                    [
                                      ],
            pushable_properties :=
                                    [ "IsGeneralizedMorphism",
                                      "IsGeneralizedMonomorphism",
                                      "IsMonomorphism",
                                      "IsSplitMonomorphism"
                                      ],
            pushable_attributes :=
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
        LISHVMOR.pullable_properties,
        Concatenation( LIGrHOM.intrinsic_properties, LIGrHOM.intrinsic_attributes ),
        UnderlyingGradedMap );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsMorphismOfCoherentSheavesOnProjRep,
       LISHVMOR.pushable_properties,
        UnderlyingGradedMap );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsMorphismOfCoherentSheavesOnProjRep, -10,
        
  function( phi )
    local psi;
    
    psi := UnderlyingGradedMap;
    
    if HasIsZero( psi ) and IsZero( psi ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

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
    
    Assert( 1, IsMorphism( emb ) );
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
InstallMethod( IsAutomorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsAutomorphism( TruncatedModuleOfGlobalSections( phi ) ) and IsEndomorphismOfSheavesOfModules( phi );
    
end );

##
InstallMethod( IsZero,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsZero( ImageObject( UnderlyingGradedMap( phi ) ) );
    
end );

##
InstallMethod( IsMorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsMorphism( UnderlyingGradedMap( phi ) );
    
end );