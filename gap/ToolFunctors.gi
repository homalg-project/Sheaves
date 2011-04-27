#############################################################################
##
##  ToolFunctors.gi                                          Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## TheZeroMorphism
##

InstallGlobalFunction( _Functor_TheZeroMorphism_OnCoherentSheafOnProj,  ### defines: TheZeroMorphism
  function( M, N )
    
    return SheafMorphism( TheZeroMorphism( UnderlyingGradedModule( M ), UnderlyingGradedModule( N ) ), M, N );
    
end );

InstallValue( functor_TheZeroMorphism_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "TheZeroMorphism" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "TheZeroMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "2", [ [ "covariant" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "OnObjects", _Functor_TheZeroMorphism_OnCoherentSheafOnProj ]
                )
        );

functor_TheZeroMorphism_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_TheZeroMorphism_ForCoherentSheafOnProj );

##
## AddMorphisms
##

InstallGlobalFunction( _Functor_AddMorphisms_OnMorphismsOfCoherentSheafOnProj,  ### defines: AddMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := SheafMorphism( UnderlyingGradedMap( phi1 ) + UnderlyingGradedMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfSumMorphism( phi1, phi2, phi );
    
end );

InstallValue( functor_AddMorphisms_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "+" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "+" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_AddMorphisms_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_AddMorphisms_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_AddMorphisms_ForMorphismsOfCoherentSheafOnProj );

##
## SubMorphisms
##

InstallGlobalFunction( _Functor_SubMorphisms_OnMorphismsOfCoherentSheafOnProj,  ### defines: SubMorphisms
  function( phi1, phi2 )
    local phi;
    
    if not AreComparableMorphisms( phi1, phi2 ) then
        return Error( "the two maps are not comparable" );
    fi;
    
    phi := SheafMorphism( UnderlyingGradedMap( phi1 ) - UnderlyingGradedMap( phi2 ), Source( phi1 ), Range( phi1 ) );
    
    return SetPropertiesOfDifferenceMorphism( phi1, phi2, phi );
    
end );

InstallValue( functor_SubMorphisms_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "-" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "-" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_SubMorphisms_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_SubMorphisms_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_SubMorphisms_ForMorphismsOfCoherentSheafOnProj );

##
## Compose
##

InstallGlobalFunction( _Functor_PreCompose_OnMorphismsOfCoherentSheafOnProj,  ### defines: PreCompose
  function( pre, post )
    local phi;
    
    if not IsIdenticalObj( Range( pre ), Source( post ) ) then
      Error( "Morphisms are not compatible for composition" );
    fi;
    
    phi := SheafMorphism( PreCompose( UnderlyingGradedMap( pre ), UnderlyingGradedMap( post ) ), Source( pre ), Range( post ) );
    
    return SetPropertiesOfComposedMorphism( pre, post, phi );
    
end );

InstallValue( functor_PreCompose_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "PreCompose" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "PreComposeMorphisms" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_PreCompose_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_PreCompose_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_PreCompose_ForMorphismsOfCoherentSheafOnProj );

##
## CoproductMorphism
##

InstallGlobalFunction( _Functor_CoproductMorphism_OnMorphismsOfCoherentSheafOnProj, ### defines: CoproductMorphism
  function( phi, psi )
    local phi_psi;
    
    phi_psi := CoproductMorphism( UnderlyingGradedMap( phi ), UnderlyingGradedMap( psi ) );
    
    phi_psi := SheafMorphism( phi_psi, Source( phi ) + Source( psi ), Range( phi ) );
    
    return SetPropertiesOfCoproductMorphism( phi, psi, phi_psi );
    
end );

InstallValue( functor_CoproductMorphism_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "CoproductMorphism" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "CoproductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_CoproductMorphism_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_CoproductMorphism_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_CoproductMorphism_ForMorphismsOfCoherentSheafOnProj );

##
## ProductMorphism
##

InstallGlobalFunction( _Functor_ProductMorphism_OnMorphismsOfCoherentSheafOnProj, ### defines: ProductMorphism
  function( phi, psi )
    local phi_psi;
    
    phi_psi := ProductMorphism( UnderlyingGradedMap( phi ), UnderlyingGradedMap( psi ) );
    
    phi_psi := SheafMorphism( phi_psi, Source( phi ), Range( phi ) + Range( psi ) );
    
    return SetPropertiesOfProductMorphism( phi, psi, phi_psi );
    
end );

InstallValue( functor_ProductMorphism_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "ProductMorphism" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "ProductMorphism" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_ProductMorphism_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_ProductMorphism_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

#=======================================================================
# PostDivide
#
# M_ is free or beta is injective ( cf. [BR08, Subsection 3.1.1] )
#
#     M_
#     |   \
#  (psi=?)  \ (gamma)
#     |       \
#     v         v
#     N_ -(beta)-> N
#
#
# row convention (left modules): psi := gamma * beta^(-1) ( -> RightDivide )
# column convention (right modules): psi := beta^(-1) * gamma ( -> LeftDivide )
#_______________________________________________________________________

##
## PostDivide
##

InstallGlobalFunction( _Functor_PostDivide_OnMorphismsOfCoherentSheafOnProj,  ### defines: PostDivide
  function( gamma, beta )
    local N, psi, M_;
    
    N := Range( beta );
    
    psi := PostDivide( UnderlyingGradedMap( gamma ), UnderlyingGradedMap( beta ) );
    
    M_ := Source( gamma );
    
    psi := SheafMorphism( psi, M_, Source( beta ) );
    
    if HasIsMorphism( gamma ) and IsMorphism( gamma ) and
       ( ( HasNrRelations( M_ ) and NrRelations( M_ ) = 0 ) or    ## [BR08, Subsection 3.1.1,(1)]
         ( HasIsMonomorphism( beta ) and IsMonomorphism( beta ) ) or  ## [BR08, Subsection 3.1.1,(2)]
         ( HasIsGeneralizedMonomorphism( beta ) and IsGeneralizedMonomorphism( beta ) ) ) then  ## "generalizes" [BR08, Subsection 3.1.1,(2)]
        
        Assert( 2, IsMorphism( psi ) );
        
        SetIsMorphism( psi, true );
        
    elif HasMorphismAid( gamma ) and not HasMorphismAid( beta ) then
        
        #### we cannot activate the following lines, since MorphismAid( gamma ) / beta fails in general (cf. the example Grothendieck.g)
        #### instead one should activate them where they make sense (cf. SpectralSequences.gi)
        #SetMorphismAid( psi, MorphismAid( gamma ) / beta );
        #SetIsGeneralizedMorphism( psi, true );
        
    fi;
    
    return psi;
    
end );

InstallValue( functor_PostDivide_ForMorphismsOfCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "PostDivide" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "PostDivide" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "2", [ [ "covariant" ], [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_PostDivide_OnMorphismsOfCoherentSheafOnProj ]
                )
        );

functor_PostDivide_ForMorphismsOfCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_PostDivide_ForMorphismsOfCoherentSheafOnProj );
