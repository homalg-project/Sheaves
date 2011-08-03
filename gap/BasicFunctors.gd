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

DeclareGlobalVariable( "functor_Cokernel_ForCoherentSheafOnProj" );


## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_ImageObject_ForCoherentSheafOnProj" );

## SheafHom
DeclareGlobalFunction( "_Functor_SheafHom_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_SheafHom_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "Functor_SheafHom_ForCoherentSheafOnProj" );

DeclareOperation( "SheafHom",
        [ IsStructureObjectOrObject, IsStructureObjectOrObject ] );

DeclareOperation( "SheafExt",
        [ IsInt, IsStructureObjectOrObject, IsStructureObjectOrObject ] );

## SheafHomOnGlobalSections

DeclareGlobalFunction( "_Functor_SheafHomOnGlobalSections_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_SheafHomOnGlobalSections_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "Functor_SheafHomOnGlobalSections_ForCoherentSheafOnProj" );

DeclareOperation( "SheafHomOnGlobalSections",
        [ IsStructureObjectOrObject, IsStructureObjectOrObject ] );

DeclareOperation( "SheafExtOnGlobalSections",
        [ IsInt, IsStructureObjectOrObject, IsStructureObjectOrObject ] );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnCoherentSheafOnProj" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "Functor_TensorProduct_ForSheaves" );