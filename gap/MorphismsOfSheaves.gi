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
  function( phi, F, G )
    local type, morphism;

    if not IsIdenticalObj( UnderlyingGradedModule( F ), Source( phi ) ) and not IsIdenticalObj( F!.GradedModuleModelingTheSheaf, Source( phi ) ) then
        Error( "the underlying graded modules for the source and second parameter do not match" );
    fi;
    if not IsIdenticalObj( UnderlyingGradedModule( G ), Range( phi ) ) and not IsIdenticalObj( G!.GradedModuleModelingTheSheaf, Range( phi ) ) then
        Error( "the underlying graded modules for the range and third parameter do not match" );
    fi;
    
    if HasTruncatedModuleOfGlobalSections( F ) and 
       IsIdenticalObj( UnderlyingGradedModule( F ), Source( phi ) ) and 
       not ( HasTruncatedModuleOfGlobalSections( G ) and IsIdenticalObj( UnderlyingGradedModule( G ), Range( phi ) ) ) then
        Error( "the source of the morphism is a truncated module of global sections, but the range is not" );
    fi;
    if HasTruncatedModuleOfGlobalSections( G ) and 
       IsIdenticalObj( UnderlyingGradedModule( G ), Range( phi ) ) and 
       not ( HasTruncatedModuleOfGlobalSections( F ) and IsIdenticalObj( UnderlyingGradedModule( F ), Source( phi ) ) ) then
        Error( "the range of the morphism is a truncated module of global sections, but the source is not" );
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

    morphism := rec( );

    ## Objectify:
    ObjectifyWithAttributes(
        morphism, type,
        Source, F,
        Range, G
    );
    
    morphism!.GradedModuleMapModelingTheSheaf := phi;
    
    if HasTruncatedModuleOfGlobalSections( F ) and 
       IsIdenticalObj( UnderlyingGradedModule( F ), Source( phi ) ) then
        SetTruncatedModuleOfGlobalSections( morphism, phi );
    fi;
    
    return morphism;
    
end );

InstallMethod( SheafZeroMorphism,
        "For graded modules",
        [ IsCoherentSheafOnProjRep, IsCoherentSheafOnProjRep ],
  function( F, G )
  
    return SheafMorphism( GradedZeroMap( UnderlyingGradedModule( F ), UnderlyingGradedModule( G ) ), F, G );
  
end );
