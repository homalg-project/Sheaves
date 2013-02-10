#############################################################################
##
##  Schemes.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for schemes.
##
#############################################################################

# a new representation for the GAP-category IsScheme

##  <#GAPDoc Label="IsSchemeRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsSchemeRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of schemes. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsScheme"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSchemeRep",
        IsScheme,
        [  ] );

##  <#GAPDoc Label="IsProjSchemeRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsProjSchemeRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of projective schemes. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsScheme"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsProjSchemeRep",
        IsSchemeRep,
        [  ] );

####################################
#
# families and types:
#
####################################

##
BindGlobal( "TheFamilyOfSchemes",
        NewFamily( "TheFamilyOfSchemes" ) );

##
BindGlobal( "TheTypeScheme",
        NewType( TheFamilyOfSchemes,
                IsSchemeRep ) );

##
BindGlobal( "TheTypeProjectiveScheme",
        NewType( TheFamilyOfSchemes,
                IsProjSchemeRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    
    return HomalgRing( StructureSheaf( X ) );
    
end );

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    
    return StructureSheaf( X );
    
end );

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for schemes",
        [ IsScheme and HasIdealSheaf ],
        
  function( X )
    
    return StructureSheafOfAmbientSpace( IdealSheaf( X ) );
    
end );

##
InstallMethod( DimensionOfAmbientSpace,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    
    return Dimension( StructureSheafOfAmbientSpace( X ) );
    
end );

##
InstallMethod( VanishingIdeal,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local J;
    
    J := IdealSheaf( X );
    
    return UnderlyingGradedModule( J );
    
end );

##
InstallMethod( UnderlyingGradedModule,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local OX;
    
    OX := StructureSheaf( X );
    
    OX := AsModuleOverStructureSheafOfAmbientSpace( OX );
    
    return UnderlyingGradedModule( OX );
    
end );

##
InstallMethod( EQ,
        "for schemes",
        [ IsScheme and HasIdealSheaf, IsScheme and HasIdealSheaf ],
        
  function( X, Y )
    local b;
    
    ## TODO: install EQ for ideal sheaves
    b := UnderlyingGradedModule( IdealSheaf( X ) ) = UnderlyingGradedModule( IdealSheaf( Y ) );
    
    if b then
        MatchPropertiesAndAttributes( X, Y, LISCM.intrinsic_properties, LISCM.intrinsic_attributes );
    fi;
    
    return b;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Spec,
        "constructor for affine schemes",
        [ IsHomalgRing ],
        
  function( R )
    local A, X, O, J;
    
    if IsBound( R!.Spec ) then
        return R!.Spec;
    fi;
    
    ## the ambient ring
    #if HasAmbientRing( R ) then
    #    A := AmbientRing( R );
    #else
    #    A := R;
    #fi;
    
    X := rec( );
    
    O := StructureSheafOfSpec( R );
    
    ObjectifyWithAttributes(
            X, TheTypeScheme,
            StructureSheaf, O,
            IsAffine, true
            );
    
    if HasDefiningIdeal( R ) then
        J := DefiningIdeal( R );
        SetIdealSheaf( X, Sheafify( J ) );
    fi;
    
    if IsBound( O!.base_ring ) then
        SetBaseRing( X, O!.base_ring );
    fi;
    
    if HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) and
       not HasAmbientRing( R ) then
        SetIsAffineSpace( X, true );
    fi;
    
    if HasIsLocal( R ) then
        SetIsLocal( X, IsLocal( R ) );
    fi;
    
    ## save the afine scheme in the ring
    R!.Spec := X;
    
    return X;
    
end );

##
InstallMethod( Proj,
        "constructor for Proj schemes",
        [ IsHomalgGradedRing ],
        
  function( S )
    local R, X, O, J;
    
    if IsBound( S!.Proj ) then
        return S!.Proj;
    fi;
    
    ## the ring carrying the weights
    #if HasAmbientRing( S ) then
    #    R := AmbientRing( S );
    #else
    #    R := S;
    #fi;
    
    X := rec( );
    
    O := StructureSheafOfProj( S );
    
    ObjectifyWithAttributes(
            X, TheTypeProjectiveScheme,
            StructureSheaf, O,
            IsProjective, true
            );
    
    if HasDefiningIdeal( S ) then
        J := DefiningIdeal( S );
        SetIdealSheaf( X, Sheafify( J ) );
    fi;
    
    if IsBound( O!.base_ring ) then
        SetBaseRing( X, O!.base_ring );
    fi;
    
    if HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) and
       not HasAmbientRing( S ) then
        SetIsProjectiveSpace( X, true );
    fi;
    
    ## save the proj scheme in the graded ring
    S!.Proj := X;
    
    return X;
    
end );

##
InstallMethod( Scheme,
        "constructor for affine schemes",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    
    return Spec( HomalgRing( I ) / I );
    
end );

##
InstallMethod( Scheme,
        "constructor for Proj schemes",
        [ IsGradedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    
    return Proj( HomalgRing( I ) / I );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme ],
        
  function( X )
    local first_property, second_property, prop_attr, print_non_empty, dim, T;
    
    first_property := false;
    second_property := false;
    
    Print( "<A" );
    
    prop_attr := "";
    
    print_non_empty := true;
    
    if HasIsProjective( X ) and IsProjective( X ) then
        Append( prop_attr, " projective" );
    fi;
    
    if HasIsSmooth( X ) then
        if IsSmooth( X ) then
            Append( prop_attr, " smooth" );
        else
            Append( prop_attr, " singular" );
            print_non_empty := false;
        fi;
    fi;
    
    if HasDimension( X ) then
        dim := Dimension( X );
        if dim < 0 then
            Append( prop_attr, " scheme" );
        elif dim = 0 then
            Append( prop_attr, " 0-dimensional scheme" );
        elif dim = 1 then
            Append( prop_attr, " curve" );
        elif dim = 2 then
            Append( prop_attr, " surface" );
        else
            Append( prop_attr,  Concatenation( " ", String( dim ), "-fold" ) );
        fi;
        if dim < 0 then
            print_non_empty := true;
        else
            print_non_empty := false;
        fi;
    else
        Append( prop_attr, " scheme" );
    fi;
    
    if HasGenus( X ) then
        Append( prop_attr, Concatenation( " with g=", String( Genus( X ) ) ) );
	first_property := true;
    fi;
    
    if HasArithmeticGenus( X ) then
        if first_property then
            Append( prop_attr, "," );
            second_property := true;
        else
            Append( prop_attr, " with" );
        fi;
        Append( prop_attr, Concatenation( " p_a=", String( ArithmeticGenus( X ) ) ) );
    fi;
    
    if HasDegreeAsSubscheme( X ) then
        if second_property then
            Append( prop_attr, ", and" );
        elif first_property then
            Append( prop_attr, " and" );
        else
            Append( prop_attr, " of" );
        fi;
        Append( prop_attr, Concatenation( " degree ", String( DegreeAsSubscheme( X ) ) ) );
    fi;
    
    if print_non_empty and HasIsEmpty( X ) and not IsEmpty( X ) then
        Print( " non-empty" );
    fi;
    
    if IsProjSchemeRep( X ) then
        Print( prop_attr, " in P^", DimensionOfAmbientSpace( X ) );
    elif HasIsAffine( X ) and IsAffine( X ) then
        if HasIsLocal( X ) and IsLocal( X ) then
            Print( prop_attr, " in A_p^", DimensionOfAmbientSpace( X ) );
        else
            Print( prop_attr, " in A^", DimensionOfAmbientSpace( X ) );
        fi;
    fi;
    
    if HasBaseRing( X ) then
        Print( " over " );
        T := BaseRing( X );
        if IsHomalgGradedRingRep( T ) then;
            T := UnderlyingNonGradedRing( T );
        fi;
        ViewObj( T );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme and IsAffineSpace ],
        
  function( X )
    local R, T;
    
    R := StructureSheaf( X )!.ring;
    
    if HasAmbientRing( R ) then
        TryNextMethod( );
    fi;
    
    if HasIsLocal( X ) and IsLocal( X ) then
        Print( "<An affine space A_p^", DimensionOfAmbientSpace( X ) );
    else
        Print( "<An affine space A^", DimensionOfAmbientSpace( X ) );
    fi;
    
    if HasBaseRing( X ) then
        Print( " over " );
        T := BaseRing( X );
        if IsHomalgGradedRingRep( T ) then;
            T := UnderlyingNonGradedRing( T );
        fi;
        ViewObj( T );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme and IsProjectiveSpace ],
        
  function( X )
    local R, T;
    
    R := StructureSheaf( X )!.graded_ring;
    
    if HasAmbientRing( R ) then
        TryNextMethod( );
    fi;
    
    Print( "<A projective space P^", DimensionOfAmbientSpace( X ) );
    
    if HasBaseRing( X ) then
        Print( " over " );
        T := BaseRing( X );
        if IsHomalgGradedRingRep( T ) then;
            T := UnderlyingNonGradedRing( T );
        fi;
        ViewObj( T );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for schemes",
        [ IsScheme and IsEmpty ],
        
  function( X )
    local dim;
    
    Print( "<An empty" );
    
    if HasIsProjective( X ) and IsProjective( X ) then
        Print( " (projective)" );
    fi;
    
    Print( "scheme>" );
    
end );

##
InstallMethod( Display,
        "for Proj schemes",
        [ IsProjSchemeRep and IsProjective ],
        
  function( X )
    
    ViewObj( HomalgRing( StructureSheaf( X ) ) );
    
    Print( "\n\nProj of the above graded ring\n" );
    
end );
