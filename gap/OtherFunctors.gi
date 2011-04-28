#############################################################################
##
##  OtherFunctors.gi                                         Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

##
## DirectSum
##

InstallGlobalFunction( _Functor_DirectSum_OnCoherentSheafOnProj,  ### defines: DirectSum
  function( F, G )
    local sum, iotaF, iotaG, piF, piG, natural, phi;
    
    CheckIfTheyLieInTheSameCategory( F, G );
    
    sum := DirectSum( UnderlyingGradedModule( F ), UnderlyingGradedModule( G ) );
    
    # take the graded natural transformations
    iotaF := MonoOfLeftSummand( sum );
    iotaG:= MonoOfRightSummand( sum );
    piF := EpiOnLeftFactor( sum );
    piG := EpiOnRightFactor( sum );
    
    natural := NaturalGeneralizedEmbedding( sum );
    sum := Proj( sum );
    natural := SheafMorphism( natural, sum, "create" );
    sum!.NaturalGeneralizedEmbedding := natural;
    
    # grade the natural transformations
    iotaF := SheafMorphism( iotaF, F, sum );
    iotaG := SheafMorphism( iotaG, G, sum );
    piF := SheafMorphism( piF, sum, F );
    piG := SheafMorphism( piG, sum, G );
    
    return SetPropertiesOfDirectSum( [ F, G ], sum, iotaF, iotaG, piF, piG );
    
end );

InstallValue( Functor_DirectSum_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "DirectSum" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "DirectSumOp" ],
                [ "natural_transformation1", "EpiOnLeftFactor" ],
                [ "natural_transformation2", "EpiOnRightFactor" ],
                [ "natural_transformation3", "MonoOfLeftSummand" ],
                [ "natural_transformation4", "MonoOfRightSummand" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "2", [ [ "covariant" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "OnObjects", _Functor_DirectSum_OnCoherentSheafOnProj ],
                [ "OnMorphismsHull", _Functor_DirectSum_OnMaps ]
                )
        );

Functor_DirectSum_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_DirectSum_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_DirectSum_ForCoherentSheafOnProj );

##
## GlobalSection
##

InstallGlobalFunction( _Functor_GlobalSections_OnCoherentSheafOnProj,  ### defines: GlobalSection
  function( F )
    
    return HomogeneousPartOfDegreeZeroOverCoefficientsRing( TruncatedModuleOfGlobalSections( F ) );
    
end );

InstallGlobalFunction( _Functor_GlobalSections_ForMorphismsOfCoherentSheafOnProj,  ### defines: GlobalSection
  function( phi )
    
    return HomogeneousPartOfDegreeZeroOverCoefficientsRing( TruncatedModuleOfGlobalSections( phi ) );
    
end );

InstallValue( Functor_GlobalSections_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "GlobalSections" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "GlobalSections" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left exact" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "OnObjects", _Functor_GlobalSections_OnCoherentSheafOnProj ],
                [ "OnMorphisms", _Functor_GlobalSections_ForMorphismsOfCoherentSheafOnProj ]
                )
        );

Functor_GlobalSections_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_GlobalSections_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_GlobalSections_ForCoherentSheafOnProj );

##
## Hom
##

ComposeFunctors( Functor_GlobalSections_ForCoherentSheafOnProj, 1, Functor_SheafHom_ForCoherentSheafOnProj, "Hom", "Hom" );

##
## Ext
##

RightSatelliteOfCofunctor( Functor_Hom_for_coherent_sheaves_on_proj, "Ext" );
