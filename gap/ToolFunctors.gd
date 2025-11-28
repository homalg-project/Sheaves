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

## AddMorphisms
DeclareGlobalFunction( "_Functor_AddMorphisms_OnMorphismsOfCoherentSheafOnProj" );

## SubMorphisms
DeclareGlobalFunction( "_Functor_SubMorphisms_OnMorphismsOfCoherentSheafOnProj" );

## Compose
DeclareGlobalFunction( "_Functor_PreCompose_OnMorphismsOfCoherentSheafOnProj" );

## CoproductMorphism
DeclareGlobalFunction( "_Functor_CoproductMorphism_OnMorphismsOfCoherentSheafOnProj" );

## ProductMorphism
DeclareGlobalFunction( "_Functor_ProductMorphism_OnMorphismsOfCoherentSheafOnProj" );

## PostDivide
DeclareGlobalFunction( "_Functor_PostDivide_OnMorphismsOfCoherentSheafOnProj" );
