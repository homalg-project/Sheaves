#############################################################################
##
##  BasicFunctors.gd                                         Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Cokernel
DeclareGlobalFunction( "_Functor_Cokernel_OnCoherentSheafOnProj" );

## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnCoherentSheafOnProj" );

## SheafHom
DeclareGlobalFunction( "_Functor_SheafHom_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_SheafHom_OnMorphismsOfCoherentSheafOnProj" );

DeclareOperation( "SheafHom",
        [ IsHomalgSheafOrMorphismOfSheaves, IsHomalgSheafOrMorphismOfSheaves ] );

DeclareOperation( "SheafExt",
        [ IsInt, IsHomalgSheafOrMorphismOfSheaves, IsHomalgSheafOrMorphismOfSheaves ] );

## SheafHomOnGlobalSections

DeclareGlobalFunction( "_Functor_SheafHomOnGlobalSections_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_SheafHomOnGlobalSections_OnMorphismsOfCoherentSheafOnProj" );

DeclareOperation( "SheafHomOnGlobalSections",
        [ IsStructureObjectOrObject, IsStructureObjectOrObject ] );

DeclareOperation( "SheafExtOnGlobalSections",
        [ IsInt, IsStructureObjectOrObject, IsStructureObjectOrObject ] );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnMorphismsOfCoherentSheafOnProj" );
