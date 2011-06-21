#############################################################################
##
##  UnderlyingModule.gi
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

##
InstallMethod( EpiOnRightFactor,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, epi;
    
    M := UnderlyingGradedModule( F );
    
    if HasEpiOnRightFactor( M ) then
        
        epi := SheafMorphism( EpiOnRightFactor( M ), F, "create" );
        
        SetEpiOnRightFactor( F, epi );
        
        return epi;
        
    fi;
     
     TryNextMethod( );
     
end );

##
InstallMethod( EpiOnLeftFactor,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, epi;
    
    M := UnderlyingGradedModule( F );
    
    if HasEpiOnLeftFactor( M ) then
        
        epi := SheafMorphism( EpiOnLeftFactor( M ), F, "create" );
        
        SetEpiOnLeftFactor( F, epi );
        
        return epi;
        
    fi;
     
     TryNextMethod( );
     
end );

##
InstallMethod( MonoOfRightSummand,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, mono;
    
    M := UnderlyingGradedModule( F );
    
    if HasMonoOfRightSummand( M ) then
        
        mono := SheafMorphism( MonoOfRightSummand( M ), "create", F );
        
        SetMonoOfRightSummand( F, mono );
        
        return mono;
        
    fi;
     
     TryNextMethod( );
     
end );

##
InstallMethod( MonoOfLeftSummand,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, mono;
    
    M := UnderlyingGradedModule( F );
    
    if HasMonoOfLeftSummand( M ) then
        
        mono := SheafMorphism( MonoOfLeftSummand( M ), "create", F );
        
        SetMonoOfLeftSummand( F, mono );
        
        return mono;
        
    fi;
     
     TryNextMethod( );
     
end );

##
InstallMethod( TheMorphismToZero,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return SheafMorphism( TheMorphismToZero( UnderlyingGradedModule( F ) ), F, "create" );
     
end );

##
InstallMethod( PositionOfTheDefaultPresentation,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M, HM;
    
    return [ F!.PositionOfTheDefaultPresentation, PositionOfTheDefaultPresentation( UnderlyingGradedModule( F ) ) ];
    
end );

##
InstallMethod( SetPositionOfTheDefaultPresentation,
        "for homalg graded modules",
        [ IsCoherentSheafOnProjRep, IsList ],
        
  function( F, p )
    
    if not ( Length( p ) = 2 and IsPosInt( p[2] ) and IsPosInt( p[1] ) ) and p[1] in F!.ListOfKnownUnderlyingModules then
        Error( "unknown presentation" );
    fi;
    
    F!.PositionOfTheDefaultPresentation := p[1];
    
    SetPositionOfTheDefaultPresentation( UnderlyingGradedModule( F ), p[2] );
    
end );

##
InstallMethod( HasNrGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return HasNrGenerators( UnderlyingGradedModule( F ) );
    
end );

InstallMethod( NrGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return NrGenerators( UnderlyingGradedModule( F ) );
    
end );

InstallMethod( CertainGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep, IsList ],
        
  function( F, a )
    
    return CertainGenerators( UnderlyingGradedModule( F ), a );
    
end );

InstallMethod( CertainGenerator,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep, IsPosInt ],
        
  function( F, a )
    
    return CertainGenerator( UnderlyingGradedModule( F ), a );
    
end );

InstallMethod( HasNrRelations,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return HasNrGenerators( UnderlyingGradedModule( F ) );
    
end );

InstallMethod( NrRelations,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return NrRelations( UnderlyingGradedModule( F ) );
    
end );

InstallMethod( ByASmallerPresentation,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local M;
    
    M := UnderlyingGradedModule( F );
    
    ByASmallerPresentation( M );
    
    return F;
    
end );

##
InstallMethod( SetsOfGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return SetsOfGenerators( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( SetsOfRelations,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return SetsOfRelations( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( ListOfPositionsOfKnownSetsOfRelations,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local n;
    
    if HasTruncatedModuleOfGlobalSections( F ) then
        n := 1;
    else
        n := 0;
    fi;
    
    return List( ListOfPositionsOfKnownSetsOfRelations( UnderlyingGradedModule( F ) ),
                  function( a ) return [ n, a ]; end
    );
    
end );

##
InstallMethod( GeneratorsOfSheaf,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return GeneratorsOfModule( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( RelationsOfSheaf,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return RelationsOfModule( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return MatrixOfGenerators( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return MatrixOfRelations( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( F )
    
    return SyzygiesGenerators( TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for coherent sheaves on proj",
        [ IsHomalgMatrix, IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( A, F )
    
    return SyzygiesGenerators( A, TruncatedModuleOfGlobalSections( F ) );
    
end );


##
InstallMethod( ReducedSyzygiesGenerators,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( F )
    
    return ReducedSyzygiesGenerators( TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for coherent sheaves on proj",
        [ IsHomalgMatrix, IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( A, F )
  
    return ReducedSyzygiesGenerators( A, TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( BasisOfSheaf,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( F )
    
    return BasisOfModule( TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( BasisOfSheaf,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return BasisOfModule( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return BasisOfSheaf( F );
    
end );

##
InstallMethod( DecideZero,
        "for coherent sheaves on proj",
        [ IsHomalgMatrix, IsCoherentSheafOrSubsheafOnProjRep and HasTruncatedModuleOfGlobalSections ],
        
  function( A, F )
    return DecideZero( A, TruncatedModuleOfGlobalSections( F ) );
    
end );

##
InstallMethod( UnionOfRelations,
        "for coherent sheaves on proj",
        [ IsHomalgMatrix, IsCoherentSheafOnProjRep ],
        
  function( A, F )
    
    return UnionOfRelations( A, UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( AnIsomorphism,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local psi;
    
    psi := SheafMorphism( AnIsomorphism( UnderlyingGradedModule( F ) ), "create", F );
    
    SetIsIsomorphism( psi, true );
    UpdateObjectsByMorphism( psi );
    
    return psi;
    
end );

##
InstallMethod( IsSubset,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep, IsCoherentSubsheafOnProjRep ],
        
  function( K, J )  ## GAP-standard: is J a subset of K
    
    return IsSubset( UnderlyingGradedModule( K ), UnderlyingGradedModule( J ) );
    
end );

##
InstallMethod( Intersect2,
        "for coherent sheaves on proj",
        [ IsCoherentSubsheafOnProjRep, IsCoherentSubsheafOnProjRep ],
        
  function( K, J )
    local F, int, map;
    
    F := SuperObject( J );
    
    if not IsIdenticalObj( F, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    int := Intersect2( UnderlyingGradedModule( K ), UnderlyingGradedModule( J ) );
    
    map := SheafMorphism( int!.map_having_subobject_as_its_image, "create", F );
    
    return ImageSubobject( map );
    
end );

InstallOtherMethod( SubobjectQuotient,
        "for coherent sheaves on proj",
        [ IsCoherentSubsheafOnProjRep, IsCoherentSubsheafOnProjRep ],
        
  function( K, J )
    local result;
    
    result := SubobjectQuotient( UnderlyingGradedModule( K ), UnderlyingGradedModule( J ) );
    
    result := SheafMorphism( result!.map_having_subobject_as_its_image, "create", SuperObject( K ) );
    
    return ImageSubobject( result );
    
end );

##
InstallMethod( BoundForResolution,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],

  function( F )
    
    return BoundForResolution( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( TheIdentityMorphism,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return SheafMorphism( TheIdentityMorphism( UnderlyingGradedModule( F ) ), F, F );
    
end );