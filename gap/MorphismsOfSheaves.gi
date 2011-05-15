#############################################################################
##
##  SheafMap.gi                                             Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsMorphismOfCoherentSheavesOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="phi" Name="IsMorphismOfCoherentSheavesOnProjRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of maps between coherent sheaves on a projective scheme modelled by a map between graded modules. <P/>
##      (It is a representation of the &GAP; categories <C>IsMorphismOfSheavesOfModules</C>,
##       and <C>IsStaticMorphismOfFinitelyGeneratedObjectsRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsMorphismOfCoherentSheavesOnProjRep",
        IsMorphismOfSheavesOfModules and
        IsStaticMorphismOfFinitelyGeneratedObjectsRep,
        [ ] );

####################################
#
# global variables:
#
####################################

HOMALG_SHEAVES_PROJ.FunctorOn :=  [ IsCoherentSheafOnProjRep,
              IsMorphismOfCoherentSheavesOnProjRep,
              [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
              [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsCochainMorphismOfFinitelyPresentedObjectsRep ] ];

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgSheafMorphisms",
        NewFamily( "TheFamilyOfHomalgSheafMorphisms" ) );

# four new types:
BindGlobal( "TheTypeMorphismOfCoherentLeftSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeMorphismOfCoherentRightSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeEndomorphismOfCoherentLeftSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgEndomorphism and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeEndomorphismOfCoherentRightSheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgEndomorphism and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( UpdateObjectsByMorphism,
        "for graded maps",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsIsomorphism ],
        
  function( phi )
    
    UpdateObjectsByMorphism( UnderlyingGradedMap( phi ) );
    
    MatchPropertiesAndAttributes( Source( phi ), Range( phi ), LISHV.intrinsic_properties, LISHV.intrinsic_attributes );
    
end );

##
InstallMethod( PairOfPositionsOfTheDefaultPresentations,
        "for morphisms of coherent sheaves on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local pos_s, pos_t;
    
    pos_s := PositionOfTheDefaultPresentation( Source( phi ) );
    pos_t := PositionOfTheDefaultPresentation( Range( phi ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        return [ pos_s, pos_t ];
    else
        return [ pos_t, pos_s ];
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep, IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( F, psi )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedModule( F ) ), HomalgRing( UnderlyingGradedMap( psi ) ) ) then
            Error( "the rings of the underlying graded (sub)module and map of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( F ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( psi ) ) ) then
            Error( "the (sub)sheaf and morphism of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( phi, G )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedMap( phi ) ), HomalgRing( UnderlyingGradedModule( G ) ) ) then
            Error( "the rings of the underlying graded (sub)module and map of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( G ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( G ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( phi ) ) ) then
            Error( "the (sub)sheaf and morphism of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep, IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi, psi )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedMap( phi ) ), HomalgRing( UnderlyingGradedMap( psi ) ) ) then
            Error( "the rings of the underlying maps of graded modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( psi ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( phi ) ) ) then
            Error( "the morphisms of sheaves must either be both in the category of left or right sheaves\n" );
        fi;
    fi;
    
end );

##
InstallMethod( homalgResetFilters,
        "for homalg maps",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( cm )
    local property;
    
    if not IsBound( HOMALG.PropertiesOfMaps ) then
        HOMALG.PropertiesOfMaps :=
          [ IsZero,
            IsMorphism,
            IsGeneralizedMorphism,
            IsSplitMonomorphism,
            IsMonomorphism,
            IsGeneralizedMonomorphism,
            IsSplitEpimorphism,
            IsEpimorphism,
            IsGeneralizedEpimorphism,
            IsIsomorphism,
            IsGeneralizedIsomorphism ];
    fi;
    
    for property in HOMALG.PropertiesOfMaps do
        ResetFilterObj( cm, property );
    od;
    
end );

##
InstallMethod( UnderlyingGradedMap,
        "for sheaves",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    if HasTruncatedModuleOfGlobalSections( phi ) then;
        return TruncatedModuleOfGlobalSections( phi );
    fi;
    
    return phi!.GradedModuleMapModelingTheSheaf;
    
end );

##
InstallMethod( PushPresentationByIsomorphism,
        "for homalg maps",
        [ IsMorphismOfCoherentSheavesOnProjRep and IsIsomorphism ],
        
  function( phi )
    
    if not HasTruncatedModuleOfGlobalSections( phi ) then
        Error( "this method only works when the map is given between the truncated modules of global sections" );
    fi;
    
    SetIsIsomorphism( UnderlyingGradedMap( phi ), true );
    
    PushPresentationByIsomorphism( UnderlyingGradedMap( phi ) );
    
    return Range( phi );
    
end );

####################################
#
# constructors
#
####################################

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsString, IsObject ],
  function( phi, s, B )
    
    if s = "create" then
        return SheafMorphism( phi, Proj( Source( phi ) ), B );
    else
        Error( "unknown string ", s );
    fi;
    
end );

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsObject, IsString ],
  function( phi, A, s )
    
    if s = "create" then
        return SheafMorphism( phi, A, Proj( Range( phi ) ) );
    else
        Error( "unknown string ", s );
    fi;
    
end );

InstallMethod( SheafMorphism,
        "For graded morphisms",
        [ IsHomalgGradedMap, IsCoherentSheafOnProjRep, IsCoherentSheafOnProjRep ],
  function( psi, F, G )
    local phi, type, morphism;
    
    phi := psi;
    
    if HasIsModuleOfGlobalSections( Source( phi ) ) and IsModuleOfGlobalSections( Source( phi ) ) and not HasTruncatedModuleOfGlobalSections( F ) then
        TruncatedModuleOfGlobalSections( F );
    fi;
    if HasIsModuleOfGlobalSections( Range( phi ) ) and IsModuleOfGlobalSections( Range( phi ) ) and not HasTruncatedModuleOfGlobalSections( G ) then
        TruncatedModuleOfGlobalSections( G );
    fi;
    
    if not IsIdenticalObj( UnderlyingGradedModule( F ), Source( phi ) ) and not IsIdenticalObj( F!.GradedModuleModelingTheSheaf, Source( phi ) )
       and not ( HasTruncatedModuleOfGlobalSections( F ) and IsIdenticalObj( TruncatedModuleOfGlobalSections( F ), Source( phi ) ) ) then
        Error( "the underlying graded modules for the source and second parameter do not match" );
    fi;
    if not IsIdenticalObj( UnderlyingGradedModule( G ), Range( phi ) ) and not IsIdenticalObj( G!.GradedModuleModelingTheSheaf, Range( phi ) )
       and not ( HasTruncatedModuleOfGlobalSections( G ) and IsIdenticalObj( TruncatedModuleOfGlobalSections( G ), Range( phi ) ) ) then
        Error( "the underlying graded modules for the range and third parameter do not match" );
    fi;

    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        if IsIdenticalObj( F, G ) then
            type := TheTypeEndomorphismOfCoherentLeftSheavesOnProj;
        else
            type := TheTypeMorphismOfCoherentLeftSheavesOnProj;
        fi;
    else
        if IsIdenticalObj( F, G ) then
            type := TheTypeEndomorphismOfCoherentRightSheavesOnProj;
        else
            type := TheTypeMorphismOfCoherentRightSheavesOnProj;
        fi;
    fi;

    morphism := rec( GradedModuleMapModelingTheSheaf := phi );

    ## Objectify:
    ObjectifyWithAttributes(
        morphism, type,
        Source, F,
        Range, G
    );
    
    if HasIsGeneralizedMorphism( psi ) then
        SetIsGeneralizedMorphism( morphism, IsGeneralizedMorphism( psi ) );
    fi;
    
    return morphism;
    
end );

InstallMethod( SheafZeroMorphism,
        "For graded modules",
        [ IsCoherentSheafOnProjRep, IsCoherentSheafOnProjRep ],
  function( F, G )
  
    return SheafMorphism( GradedZeroMap( UnderlyingGradedModule( F ), UnderlyingGradedModule( G ) ), F, G );
  
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for morphisms of coherent sheaves on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep ], ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( o )
    
    Display( UnderlyingGradedMap( o ) );
    
    Print( "The morphism of coherent sheaves on the projective space given by the above graded map\n" );
    
end );

