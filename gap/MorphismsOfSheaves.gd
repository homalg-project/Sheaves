#############################################################################
##
##  SheafMap.gd                                             Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new categories:

##  <#GAPDoc Label="IsMorphismOfSheavesOfModules">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsMorphismOfSheavesOfModules"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf maps. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsMorphismOfSheavesOfModules",
        IsHomalgMorphism
        and IsHomalgSheafOrMorphismOfSheaves );

##  <#GAPDoc Label="IsEndomorphismOfSheavesOfModules">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsEndomorphismOfSheavesOfModules"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf self-maps. <P/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsMorphismOfSheavesOfModules</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsEndomorphismOfSheavesOfModules",
        IsMorphismOfSheavesOfModules and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

##
DeclareAttribute( "CastelnuovoMumfordRegularity",
         IsMorphismOfSheavesOfModules );


##  <#GAPDoc Label="TruncatedModuleOfGlobalSections:morphisms">
##  <ManSection>
##    <Attr Arg="phi" Name="TruncatedModuleOfGlobalSections" Label="for morphisms"/>
##    <Returns>a morphism of sheaves</Returns>
##    <Description>
##      The version of global sections of the sheaf morphism truncated (at zero) <A>phi</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TruncatedModuleOfGlobalSections",
        IsMorphismOfSheavesOfModules );

####################################
#
# global functions and operations:
#
####################################

DeclareOperation( "UnderlyingGradedMap",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "NormalizeGradedMorphism",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "SheafMorphism" ,
                 [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareOperation( "SheafZeroMorphism" ,
                 [ IsSheafOfModules, IsSheafOfModules ] );

DeclareOperation( "OnALocallyFreeSource",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "SyzygiesGenerators",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "ReducedSyzygiesGenerators",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "MatrixOfMap",
                 [ IsMorphismOfSheavesOfModules ] );

DeclareOperation( "MatrixOfMap",
                 [ IsMorphismOfSheavesOfModules, IsInt ] );

DeclareOperation( "MatrixOfMap",
                 [ IsMorphismOfSheavesOfModules, IsInt, IsInt ] );

DeclareOperation( "MatrixOfMap",
                 [ IsMorphismOfSheavesOfModules, IsInt, IsInt, IsInt ] );

DeclareOperation( "SheafVersionOfMorphismAid",
                 [ IsHomalgGradedMap, IsSheafOfModules ] );
