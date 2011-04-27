#############################################################################
##
##  ToolFunctors.gd             Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for some graded tool functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## TheZeroMorphism
DeclareGlobalFunction( "_Functor_TheZeroMorphism_OnCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_TheZeroMorphism_ForCoherentSheafOnProj" );

## AddMorphisms
DeclareGlobalFunction( "_Functor_AddMorphisms_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_AddMorphisms_ForMorphismsOfCoherentSheafOnProj" );

## SubMorphisms
DeclareGlobalFunction( "_Functor_SubMorphisms_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_SubMorphisms_ForMorphismsOfCoherentSheafOnProj" );

## Compose
DeclareGlobalFunction( "_Functor_PreCompose_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_PreCompose_ForMorphismsOfCoherentSheafOnProj" );

## CoproductMorphism
DeclareGlobalFunction( "_Functor_CoproductMorphism_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_CoproductMorphism_ForMorphismsOfCoherentSheafOnProj" );

## ProductMorphism
DeclareGlobalFunction( "_Functor_ProductMorphism_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_ProductMorphism_ForMorphismsOfCoherentSheafOnProj" );

## PostDivide
DeclareGlobalFunction( "_Functor_PostDivide_OnMorphismsOfCoherentSheafOnProj" );

DeclareGlobalVariable( "functor_PostDivide_ForMorphismsOfCoherentSheafOnProj" );