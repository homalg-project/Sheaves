#############################################################################
##
##  Sheaves.gd                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for sheaves.
##
#############################################################################

# our info classes:
DeclareInfoClass( "InfoSheaves" );
SetInfoLevel( InfoSheaves, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_SHEAVES_PROJ" );

####################################
#
# categories:
#
####################################

# four new GAP-categories:

##  <#GAPDoc Label="IsHomalgSheaf">
##  <ManSection>
##    <Filt Type="Category" Arg="O" Name="IsHomalgSheaf"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves. <P/>
##      (It is a subcategory of the &GAP; category
##      <C>IsStructureObjectOrObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheaf",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="IsSheafOfRings">
##  <ManSection>
##    <Filt Type="Category" Arg="O" Name="IsSheafOfRings"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves of rings. <P/>
##      (It is a subcategory of the &GAP; category
##      <C>IsHomalgSheaf</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafOfRings",
        IsStructureObject and IsHomalgSheaf );

##  <#GAPDoc Label="IsSheafOfModules">
##  <ManSection>
##    <Filt Type="Category" Arg="E" Name="IsSheafOfModules"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves. <P/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgSheaf</C> and <C>IsHomalgStaticObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafOfModules",
        IsHomalgSheaf and IsHomalgStaticObject );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsDirectSumOfLineBundles">
##  <ManSection>
##    <Prop Arg="E" Name="IsDirectSumOfLineBundles"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is a direct sum of line bundles.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDirectSumOfLineBundles",
        IsSheafOfModules );

##  <#GAPDoc Label="IsLocallyFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsLocallyFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is locally free (a vector bundle).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLocallyFree",
        IsSheafOfModules );

##  <#GAPDoc Label="FiniteLocallyFreeResolutionExists">
##  <ManSection>
##    <Prop Arg="E" Name="FiniteLocallyFreeResolutionExists"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> allows a finite locally free resolution. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "FiniteLocallyFreeResolutionExists",
        IsSheafOfModules );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="StructureSheafOfProj">
##  <ManSection>
##    <Attr Arg="S" Name="StructureSheafOfProj"/>
##    <Returns>a sheaf of rings</Returns>
##    <Description>
##      The structure sheaf of <M>Proj(</M><A>S</A><M>)</M> of the &homalg; graded ring <A>S</A>.
##      The grading of <A>S</A> is determined by the attribute <C>WeightsOfIndeterminates</C>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "StructureSheafOfProj",
        IsHomalgGradedRing );

##  <#GAPDoc Label="IdealSheaf:sheaf">
##  <ManSection>
##    <Attr Arg="O" Name="IdealSheaf" Label="for structure sheaves"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##      The sheaf of ideals <M>Proj(J)</M> of the &homalg; graded ideal <A>J</A>, where <A>O</A><M>=Proj(S/J)</M>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IdealSheaf",
        IsSheafOfRings );

##  <#GAPDoc Label="AsModuleOverStructureSheafOfAmbientSpace">
##  <ManSection>
##    <Attr Arg="O" Name="AsModuleOverStructureSheafOfAmbientSpace"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##      The sheaf of modules <A>O</A> regarded as a sheaf of modules over the structure sheaf of the ambient space.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AsModuleOverStructureSheafOfAmbientSpace",
        IsSheafOfRings );

##  <#GAPDoc Label="TruncatedModuleOfGlobalSections:sheaves">
##  <ManSection>
##    <Attr Arg="E" Name="TruncatedModuleOfGlobalSections" Label="for sheaves"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##      The truncated (at zero) module of global sections of the sheaf <A>E</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TruncatedModuleOfGlobalSections",
        IsHomalgSheaf );

##  <#GAPDoc Label="Support">
##  <ManSection>
##    <Attr Arg="E" Name="Support"/>
##    <Returns>a scheme</Returns>
##    <Description>
##      The support of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Support",
        IsHomalgSheaf );

##
## the attributes below are intrinsic:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to appear in
## LISHV.intrinsic_attributes_specific
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="CastelnuovoMumfordRegularity">
##  <ManSection>
##    <Attr Arg="E" Name="CastelnuovoMumfordRegularity"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Castelnuovo-Mumford regularity of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CastelnuovoMumfordRegularity",
        IsSheafOfModules );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "Sheafify",
        [ IsHomalgGradedModule ] );

DeclareOperation( "Proj",
        [ IsHomalgGradedModule ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRing ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRing ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsHomalgGradedRing, IsList ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsInt, IsHomalgGradedRing, IsInt ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsInt, IsHomalgGradedRing ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsHomalgGradedRing, IsList ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsInt, IsHomalgGradedRing, IsInt ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsInt, IsHomalgGradedRing ] );

DeclareOperation( "POW",
        [ IsSheafOfRings, IsInt ] );

DeclareOperation( "POW",
        [ IsSheafOfRings, IsList ] );


# basic operations:

DeclareOperation( "CheckHasTruncatedModuleOfGlobalSections",
        [ IsSheafOfModules, IsHomalgGradedModule ] );

DeclareOperation( "AddANewPresentation",
        [ IsSheafOfModules, IsHomalgGradedModule ] );

DeclareOperation( "StructureSheafOfAmbientSpace",
        [ IsSheafOfModules ] );

DeclareOperation( "DimensionOfAmbientSpace",
        [ IsSheafOfModules ] );

DeclareOperation( "HomalgRing",
        [ IsSheafOfRings ] );

DeclareOperation( "UnderlyingGradedModule",
        [ IsSheafOfModules ] );

DeclareOperation( "homalgProjString",
        [ IsHomalgGradedRing ] );

DeclareOperation( "GlobalSections",
        [ IsSheafOfModules ] );

DeclareOperation( "InducedMorphismToProjectiveSpace",
        [ IsSheafOfModules ] );

DeclareOperation( "SetsOfGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "SetsOfRelations",
        [ IsSheafOfModules ] );

DeclareOperation( "ListOfPositionsOfKnownSetsOfRelations",
        [ IsSheafOfModules ] );

DeclareOperation( "GeneratorsOfSheaf",
        [ IsSheafOfModules ] );

DeclareOperation( "RelationsOfSheaf",
        [ IsSheafOfModules ] );

DeclareOperation( "BasisOfSheaf",
        [ IsSheafOfModules ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "MatrixOfRelations",
        [ IsSheafOfModules ] );

DeclareOperation( "HasNrGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "NrGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "HasNrRelations",
        [ IsSheafOfModules ] );

DeclareOperation( "CertainGenerators",
        [ IsSheafOfModules, IsList ] );

DeclareOperation( "CertainGenerator",
        [ IsSheafOfModules, IsPosInt ] );

DeclareOperation( "NrRelations",
        [ IsSheafOfModules ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsSheafOfModules ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMatrix, IsSheafOfModules ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMatrix, IsSheafOfModules ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsSheafOfModules ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMatrix, IsSheafOfModules ] );

DeclareOperation( "DegreesOfGenerators",
        [ IsSheafOfModules ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonymAttr( "IsVectorBundle",
        IsLocallyFree );

