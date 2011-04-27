#############################################################################
##
##  UnderlyingMap.gi
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

##
InstallMethod( PositionOfTheDefaultPresentation,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( psi )
    
    if HasTruncatedModuleOfGlobalSections( psi ) then
        return Concatenation( [ 1 ], PairOfPositionsOfTheDefaultPresentations( UnderlyingGradedMap( psi ) ) );
    else
        return Concatenation( [ 0 ], PairOfPositionsOfTheDefaultPresentations( UnderlyingGradedMap( psi ) ) );
    fi;
    
end );

##
InstallMethod( MatrixOfMap,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return MatrixOfMap( UnderlyingGradedMap( phi ) );
    
end );

##
InstallMethod( MatrixOfMap,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsInt ],
        
  function( phi, pos )
    
    if pos = 0 then
        return MatrixOfMap( UnderlyingGradedMap( phi ) );
    elif pos = 1 then
        return MatrixOfMap( TruncatedModuleOfGlobalSections( phi ) );
    else
        Error( "no position ", pos, "known" );
    fi;
    
end );

##
InstallMethod( MatrixOfMap,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsInt, IsInt ],
        
  function( phi, pos_s, pos_t )
    
    return MatrixOfMap( UnderlyingGradedMap( phi ), pos_s, pos_t );
    
end );

##
InstallMethod( MatrixOfMap,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsInt, IsInt, IsInt ],
        
  function( phi, pos , pos_s, pos_t )
    
    if pos = 0 then
        return MatrixOfMap( UnderlyingGradedMap( phi ), pos_s, pos_t );
    elif pos = 1 then
        return MatrixOfMap( TruncatedModuleOfGlobalSections( phi ), pos_s, pos_t );
    else
        Error( "no position ", pos, "known" );
    fi;
    
end );

##
InstallMethod( DecideZero,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    if IsZero( ImageObject( UnderlyingGradedMap( phi ) ) ) then
        SetIsZero( phi, true );
    else
        SetIsZero( phi, false );
    fi;;
    
    return phi;
    
end );


##
InstallMethod( \=,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi, psi )
    
    return AreComparableMorphisms( phi, psi ) and ( UnderlyingGradedMap( phi ) = UnderlyingGradedMap( psi ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
  function( phi )
    local syz;

    syz := SyzygiesGenerators( UnderlyingGradedMap( phi ) );

    if NrRelations( syz ) = 0 then
        SetIsMonomorphism( phi, true );
    fi;

    return syz;

end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
  function( phi )
    local syz;

    syz := ReducedSyzygiesGenerators( UnderlyingGradedMap( phi ) );

    if NrRelations( syz ) = 0 then
        SetIsMonomorphism( phi, true );
    fi;

    return syz;

end );

##
InstallMethod( PostInverse,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
  function( phi )
    local inv;

    inv := PostInverse( UnderlyingGradedMap( phi ) );

    if IsHomalgMap( inv ) then
        return SheafMorphism( inv , Range( phi ), Source( phi ) );
    elif IsBool(inv) then
        return inv;
    else
        Error( "unknown return value from PostInverse" );
    fi;

end );

##
InstallMethod( PostInverse,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsMonomorphism ],
        
  function( phi )
    local result;
    
    if IsBound( phi!.PostInverse )  then
        return phi!.PostInverse;
    fi;
    
    result := PostInverse( UnderlyingGradedMap( phi ) );
    
    if IsBool( result ) then
        return result;
    fi;
    
    result := SheafMorphism( result, Range( phi ), Source( phi ) );
    
    phi!.PostInverse := result;
    
    return result;
    
end );

##
InstallMethod( PreInverse,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsEpimorphism ],
        
  function( phi )
    local result;
    
    if IsBound( phi!.PreInverse )  then
        return phi!.PreInverse;
    fi;
    
    result := PreInverse( UnderlyingGradedMap( phi ) );
    
    if IsBool( result ) then
        return result;
    fi;
    
    result := SheafMorphism( result, Range( phi ), Source( phi ) );
    
    phi!.PreInverse := result;
    
    return result;
    
end );
