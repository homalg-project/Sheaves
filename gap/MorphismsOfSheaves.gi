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

BindGlobal( "TheTypeEndomorphismOfCoherentRightheavesOnProj",
        NewType( TheFamilyOfHomalgSheafMorphisms,
                IsMorphismOfCoherentSheavesOnProjRep and IsHomalgEndomorphism and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################
