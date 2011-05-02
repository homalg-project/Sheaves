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

    if HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
        emb := SheafMorphism( emb, UnderlyingObject( ZeroSubobject( Source( phi ) ) ), Source( phi ) );
    else
        emb := SheafMorphism( emb, "create", Source( phi ) );
    fi;
    
    Assert( 1, IsMorphism( emb ) );
    SetIsMorphism( emb, true );
    
    ker := ImageSubobject( emb );
    
    target := Range( phi );
    
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
    local result;
    
    result := SheafMorphism( -UnderlyingGradedMap( phi ), Source( phi ), Range( phi ) );
    
    if HasIsMorphism( phi ) then
        SetIsMorphism( result, IsMorphism( phi ) );
    fi;
    if HasIsEpimorphism( phi )  then
        SetIsEpimorphism( result, IsEpimorphism( phi ) );
    fi;
    if HasIsMonomorphism( phi )  then
        SetIsMonomorphism( result, IsMonomorphism( phi ) );
    fi;
    
    return result;
    
end );

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
    
    return IsZero( TruncatedModuleOfGlobalSections( phi ) );
    
end );

##
InstallMethod( IsMorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsMorphism( UnderlyingGradedMap( phi ) );
    
end );