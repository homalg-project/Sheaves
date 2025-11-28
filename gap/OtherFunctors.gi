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

BindGlobal( "Functor_DirectSum_ForCoherentSheafOnProj",
        CreateHomalgFunctor(
                [ "name", "DirectSum" ],
                [ "category", HOMALG_SHEAVES.category ],
                [ "operation", "DirectSumOp" ],
                [ "natural_transformation1", "EpiOnLeftFactor" ],
                [ "natural_transformation2", "EpiOnRightFactor" ],
                [ "natural_transformation3", "MonoOfLeftSummand" ],
                [ "natural_transformation4", "MonoOfRightSummand" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], HOMALG_SHEAVES.FunctorOn ] ],
                [ "2", [ [ "covariant" ], HOMALG_SHEAVES.FunctorOn ] ],
                [ "OnObjects", _Functor_DirectSum_OnCoherentSheafOnProj ],
                [ "OnMorphismsHull", _Functor_DirectSum_OnMaps ]
                )
        );

Functor_DirectSum_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=true;

Functor_DirectSum_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=true;

InstallFunctor( Functor_DirectSum_ForCoherentSheafOnProj );
