#############################################################################
##
##  UnderlyingModule.gi
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

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
    
    if HasTruncatedModuleOfGlobalSections( F ) then
        return [ 1, PositionOfTheDefaultPresentation( UnderlyingGradedModule( F ) ) ];
    else
        return [ 0, PositionOfTheDefaultPresentation( UnderlyingGradedModule( F ) ) ];
    fi;
    
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
InstallMethod( IsZero,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F )
    
    return IsZero( TruncatedModuleOfGlobalSections( F ) );
    
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
    
    return SheafMorphism( AnIsomorphism( UnderlyingGradedModule( F ) ), "create", F );
    
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