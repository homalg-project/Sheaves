#############################################################################
##
##  Schemes.gd                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for schemes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsScheme">
##  <ManSection>
##    <Filt Type="Category" Arg="X" Name="IsScheme"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of schemes.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsScheme",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsEmpty:scheme">
##  <ManSection>
##    <Prop Arg="X" Name="IsEmpty" Label="for schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is empty.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsEmpty",
        IsScheme );

##  <#GAPDoc Label="IsAffine:scheme">
##  <ManSection>
##    <Prop Arg="X" Name="IsAffine" Label="for schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is affine. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAffine",
        IsScheme );

##  <#GAPDoc Label="IsQuasiAffine:scheme">
##  <ManSection>
##    <Prop Arg="X" Name="IsQuasiAffine" Label="for schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is quasi-affine. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsQuasiAffine",
        IsScheme );

##  <#GAPDoc Label="IsAffineSpace">
##  <ManSection>
##    <Prop Arg="X" Name="IsAffineSpace"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is an affine space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAffineSpace",
        IsScheme );

##  <#GAPDoc Label="IsLocal:scheme">
##  <ManSection>
##    <Prop Arg="X" Name="IsLocal" Label="for schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is local. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLocal",
        IsScheme );

##  <#GAPDoc Label="IsProjective:scheme">
##  <ManSection>
##    <Prop Arg="X" Name="IsProjective" Label="for schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is projective. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjective",
        IsScheme );

##  <#GAPDoc Label="IsProjectiveSpace">
##  <ManSection>
##    <Prop Arg="X" Name="IsProjectiveSpace"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is a projective space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjectiveSpace",
        IsScheme );

##  <#GAPDoc Label="IsReduced">
##  <ManSection>
##    <Prop Arg="X" Name="IsReduced"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is reduced. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReduced",
        IsScheme );

##  <#GAPDoc Label="IsSmooth">
##  <ManSection>
##    <Prop Arg="X" Name="IsSmooth"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is smooth. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSmooth",
        IsScheme );

##  <#GAPDoc Label="IsCohenMacaulay">
##  <ManSection>
##    <Prop Arg="X" Name="IsCohenMacaulay"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is Cohen-Macaulay.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCohenMacaulay",
        IsScheme );

##  <#GAPDoc Label="IsGorenstein">
##  <ManSection>
##    <Prop Arg="X" Name="IsGorenstein"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the scheme <A>X</A> is Gorenstein.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGorenstein",
        IsScheme );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="IdealSheaf:scheme">
##  <ManSection>
##    <Attr Arg="X" Name="IdealSheaf" Label="for schemes"/>
##    <Returns>a sheaf of ideals</Returns>
##    <Description>
##      The sheaf of ideals of the scheme <A>X</A> viewed as a subscheme of some ambient scheme.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IdealSheaf",
        IsSheafOfModules );

##  <#GAPDoc Label="StructureSheaf">
##  <ManSection>
##    <Attr Arg="X" Name="StructureSheaf"/>
##    <Returns>a sheaf of rings</Returns>
##    <Description>
##      The structure sheaf of the scheme <A>X</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "StructureSheaf",
        IsScheme );

##  <#GAPDoc Label="SingularLocus">
##  <ManSection>
##    <Attr Arg="X" Name="SingularLocus"/>
##    <Returns>an ideal</Returns>
##    <Description>
##      The ideal sheaf of the singular locus of the scheme <A>X</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SingularLocus",
        IsScheme );

##  <#GAPDoc Label="CanonicalSheafOnAmbientSpace">
##  <ManSection>
##    <Attr Arg="X" Name="CanonicalSheafOnAmbientSpace"/>
##    <Returns>an ideal</Returns>
##    <Description>
##      The canonical sheaf of <A>X</A> as a sheaf on the ambient space.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CanonicalSheafOnAmbientSpace",
        IsScheme );

##  <#GAPDoc Label="CanonicalSheaf">
##  <ManSection>
##    <Attr Arg="X" Name="CanonicalSheaf"/>
##    <Returns>an ideal</Returns>
##    <Description>
##      The canonical sheaf of <A>X</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CanonicalSheaf",
        IsScheme );

##  <#GAPDoc Label="IrreducibleComponents">
##  <ManSection>
##    <Attr Arg="X" Name="IrreducibleComponents"/>
##    <Returns>a list of schemes</Returns>
##    <Description>
##      The list irreducible components of the scheme <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IrreducibleComponents",
        IsScheme );

##  <#GAPDoc Label="ReducedScheme">
##  <ManSection>
##    <Attr Arg="X" Name="ReducedScheme"/>
##    <Returns>a scheme</Returns>
##    <Description>
##      The reduced scheme associated to <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ReducedScheme",
        IsScheme );

##  <#GAPDoc Label="DegreeAsSubscheme">
##  <ManSection>
##    <Attr Arg="X" Name="DegreeAsSubscheme"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The degree of the scheme <A>X</A> viewed as a subscheme in its ambient space of definition.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeAsSubscheme",
        IsScheme );

##  <#GAPDoc Label="Closure">
##  <ManSection>
##    <Attr Arg="X" Name="Closure"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The closure of a subscheme <A>X</A> in its ambient scheme.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Closure",
        IsScheme );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LISCM.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="Genus">
##  <ManSection>
##    <Attr Arg="X" Name="Genus"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The genus of the scheme <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Genus",
        IsScheme );

##  <#GAPDoc Label="ArithmeticGenus">
##  <ManSection>
##    <Attr Arg="X" Name="ArithmeticGenus"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The arithmetic genus of the scheme <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ArithmeticGenus",
        IsScheme );

##  <#GAPDoc Label="Dimension:scheme">
##  <ManSection>
##    <Attr Arg="X" Name="Dimension" Label="for schemes"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The dimension of the scheme <A>X</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsScheme );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "Proj",
        [ IsHomalgGradedRing ] );

DeclareOperation( "Spec",
        [ IsHomalgRing ] );

DeclareOperation( "Scheme",
        [ IsHomalgModule ] );

DeclareOperation( "Union2",
        [ IsScheme, IsScheme ] );

DeclareOperation( "Intersect2",
        [ IsScheme, IsScheme ] );

DeclareOperation( "Difference",
        [ IsScheme, IsScheme ] );

DeclareOperation( "Complement",
        [ IsScheme ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsScheme ] );

DeclareOperation( "IsSubset",
        [ IsScheme, IsScheme ] );

DeclareOperation( "StructureSheafOfAmbientSpace",
        [ IsScheme ] );

DeclareOperation( "DimensionOfAmbientSpace",
        [ IsScheme ] );

DeclareOperation( "VanishingIdeal",
        [ IsScheme ] );

DeclareOperation( "UnderlyingGradedModule",
        [ IsScheme ] );

####################################
#
# synonyms:
#
####################################

