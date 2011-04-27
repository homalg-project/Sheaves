
##
InstallMethod( TruncatedModuleOfGlobalSections,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep and HasMorphismAid ],
        
  function( phi )
    local psi;
    
    TruncatedModuleOfGlobalSections( MorphismAid( phi ) );
    
    if IsIdenticalObj( Range( UnderlyingGradedMap( phi ) ), TruncatedModuleOfGlobalSections( Range( phi ) ) ) then
        psi := UnderlyingGradedMap( phi );
    else
        psi := PreCompose( psi, NaturalMapToModuleOfGlobalSections( Range( psi ) ) );
    fi;
    
    SetTruncatedModuleOfGlobalSections( phi, psi );
    
    return psi;
    
end );

##
InstallMethod( GeneralizedMorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, psi;
    
    if not IsMorphismOfCoherentSheavesOnProjRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the morphism aid map
    morphism_aid_map1 := OnALocallyFreeSource( morphism_aid_map );
    
    ## prepare a copy of phi
    psi := SheafMorphism( GeneralizedMorphism( UnderlyingGradedMap( phi ), UnderlyingGradedMap( morphism_aid_map1 ) ), Source( phi ), Range( phi ) );
    
    SetMorphismAid( psi, morphism_aid_map1 );
    
    SetIsGeneralizedMorphism( psi, true );
    
    ## some properties of the morphism phi imply
    ## properties for the generalized morphism psi
    SetPropertiesOfGeneralizedMorphism( psi, phi );
    
    return psi;
    
end );
##
InstallMethod( RemoveMorphismAid,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return SheafMorphism( RemoveMorphismAid( UnderlyingGradedMap( phi ) ), Source( phi ), Range( phi ) );
    
end );

##
InstallMethod( OnALocallyFreeSource,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return SheafMorphism( OnAFreeSource( UnderlyingGradedMap( phi ) ), "create", Range( phi ) );
    
end );

##
InstallMethod( AddToMorphismAid,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsObject ],
        
  function( phi, morphism_aid_map )
    local morphism_aid_map1, morphism_aid_map0;
    
    if not IsMorphismOfCoherentSheavesOnProjRep( morphism_aid_map ) then
        return phi;
    fi;
    
    if not IsIdenticalObj( Range( phi ), Range( morphism_aid_map ) ) then
        Error( "the targets of the two morphisms must coincide\n" );
    fi;
    
    ## we don't need the source of the new morphism aid map
    morphism_aid_map1 := OnALocallyFreeSource( morphism_aid_map );
    
    if HasMorphismAid( phi ) then
        ## we don't need the source of the old morphism aid map
        morphism_aid_map0 := OnALocallyFreeSource( MorphismAid( phi ) );
        morphism_aid_map1 := CoproductMorphism( morphism_aid_map0, morphism_aid_map1 );
    fi;
    
    return GeneralizedMorphism( phi, morphism_aid_map1 );
    
end );

##
InstallMethod( AssociatedMorphism,
        "for homalg maps",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local mat, S, T;
    
    if not HasMorphismAid( phi ) then
        return phi;
    fi;
    
    SheafMorphism( AssociatedMorphism( UnderlyingGradedMap( phi ) ), Source( phi ), Range( phi ) );
    
end );