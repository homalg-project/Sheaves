#############################################################################
##
##  Divisors.gi                                              Sheaves package
##
##  Copyright 2012, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for divisors.
##
#############################################################################

# a new representation for the GAP-category IsDivisor

##  <#GAPDoc Label="IsDivisorRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="L" Name="IsDivisorRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of linear systems. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsDivisor"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsDivisorRep",
        IsDivisor,
        [ "module", "HomalgRingOfUnderlyingGradedModule" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfDivisors",
        NewFamily( "TheFamilyOfDivisors" ) );

# a new type:
BindGlobal( "TheTypeDivisor",
        NewType( TheFamilyOfDivisors,
                IsDivisorRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return HomalgRing( DefiningPolynomial( D ) );
    
end );

##
InstallMethod( DerMinusLogMap,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local map, f, R, var, n, Rn, varvec;
    
    if HasIsPrimeDivisor( D ) and not IsPrimeDivisor( D ) and
       IsBound( D!.PreFactorization ) then
        
        map := List( D!.PreFactorization, DerMinusLogMap );
        
        return Iterated( map, ProductMorphism );
        
    fi;
    
    f := DefiningPolynomial( D );
    
    R := HomalgRing( f );
    
    var := Indeterminates( R );
    
    n := Length( var );
    
    if not IsBound( R!.DerMinusLogModule ) then
        R!.DerMinusLogModule := n * R;
    fi;
    
    Rn := R!.DerMinusLogModule;
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    f := HomalgMatrix( [ f ], 1, 1, R );
    
    map := Diff( Involution( varvec ), f );
    
    if IsHomalgGradedRing( R ) then
        map := GradedMap( map, Rn, LeftPresentationWithDegrees( f ) );
    else
        map := HomalgMap( map, Rn, LeftPresentation( f ) );
    fi;
    
    return map;
    
end );

##
InstallMethod( DerMinusLogMap,
        "for divisors",
        [ IsDivisor and HasPrimeDivisorsAttr ],
        
  function( D )
    local map;
    
    if Length( PrimeDivisorsAttr( D ) ) < 2 then
        TryNextMethod( );
    fi;
    
    map := List( PrimeDivisorsAttr( D ), DerMinusLogMap );
    
    return Iterated( map, ProductMorphism );
    
end );

##
InstallMethod( DerMinusLog,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return KernelSubobject( DerMinusLogMap( D ) );
    
end );

##
InstallMethod( RingOfDerivations,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local R;
    
    R := HomalgRing( D );
    
    return RingOfDerivations( R );
    
end );

##
InstallMethod( DefiningPolynomialOverWeylAlgebra,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return DefiningPolynomial( D ) / RingOfDerivations( D );
    
end );

##
InstallMethod( DerMinusLogInWeylAlgebra,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local der, An, var;
    
    der := DerMinusLog( D );
    der := MatrixOfGenerators( der );
    
    An := RingOfDerivations( D );
    
    var := IndeterminateDerivationsOfRingOfDerivations( An );
    
    var := HomalgMatrix( var, Length( var ), 1, An );

    der := An * der;
    
    der := der * var;
    
    der := LeftSubmodule( der );
    
    return der;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Divisor,
        "constructor for divisors",
        [ IsHomalgRingElement ],
        
  function( f )
    local R, X, D;
    
    R := HomalgRing( f );
    
    if IsHomalgGradedRing( R ) then
        X := Proj( R );
    else
        X := Spec( R );
    fi;
    
    D := rec( );
    
    ObjectifyWithAttributes(
            D, TheTypeDivisor,
            AmbientScheme, X,
            DefiningPolynomial, f,
            IsZero, IsZero( f )
            );
    
    return D;
    
end );

##
InstallMethod( Divisor,
        "constructor for divisors",
        [ IsMatrix, IsHomalgRing ],
  function( A, k )
    local alpha, n, m, R, var, Rn, varvec, alphas, alphaH, D;
    
    alpha := HomalgMatrix( A, k );
    
    alpha := CertainRows( alpha, NonZeroRows( alpha ) );
    
    m := NrRows( alpha );
    n := NrColumns( alpha );
    
    alpha := Involution( alpha );
    
    ## will be graded if k is "graded"
    R := k * List( [ 1 .. n ], i -> Concatenation( "x", String( i ) ) );
    
    alpha := R * alpha;
    
    var := Indeterminates( R );
    
    Rn := n * R;
    
    if not IsBound( R!.DerMinusLogModule ) then
        R!.DerMinusLogModule := Rn;
    fi;
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    alphas := List( [ 1 .. m ], c -> CertainColumns( alpha, [ c ] ) );
    
    alphaH := List( alphas, a -> varvec * a );
    
    alphaH := List( alphaH, a -> EntriesOfHomalgMatrix( a )[ 1 ] );
    
    D := Product( alphaH );
    
    D := Divisor( D );
    
    SetPrimeDivisorsAttr( D, List( alphaH, Divisor ) );
    
    return D;
    
end );

##
InstallMethod( \+,
        "constructor for divisors",
        [ IsDivisor, IsDivisor ],
  function( D1, D2 )
    local f1, f2, D;
    
    f1 := DefiningPolynomial( D1 );
    f2 := DefiningPolynomial( D2 );
    
    D := Divisor( f1 * f2 );
    
    ## Fixme:
    SetIsPrimeDivisor( D, false );
    
    D!.PreFactorization := [ D1, D2 ];
    
    return D;
    
end );

##
InstallMethod( \*,
        "base change for divisors",
        [ IsHomalgRing, IsDivisorRep ],
        
  function( R, D )
    
    return Divisor( DefiningPolynomial( D ) / R );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for divisors",
        [ IsDivisorRep ],
        
  function( D )
    
    Print( "<A" );
    
    Print( " divisor on " );
    ViewObj( AmbientScheme( D ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
        "for divisors",
        [ IsDivisorRep ],
        
  function( D )
    
    Display( DefiningPolynomial( D ) );
    
    Print( "\nA divisor given by the above polynomial\n" );
    
end );
