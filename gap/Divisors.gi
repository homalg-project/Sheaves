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
        [ ] );

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
# methods for attributes:
#
####################################

##
InstallMethod( CharacteristicPolynomial,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local t, chi, n;
    
    t := IndeterminateOfCharacteristicPolynomial( );
    
    chi := CharacteristicPolynomial( D, t );
    
    n := KrullDimension( HomalgRing( D ) );
    
    return t^(n - Degree( chi )) * chi;
    
end );

##
InstallMethod( ProjectiveCharacteristicPolynomial,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local t;
    
    t := IndeterminateOfCharacteristicPolynomial( );
    
    return CharacteristicPolynomial( D ) / (t - 1);
    
end );

##
InstallMethod( PoincarePolynomial,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local t;
    
    t := IndeterminateOfCharacteristicPolynomial( );
    
    return PoincarePolynomial( D, t );
    
end );

##
InstallMethod( ProjectivePoincarePolynomial,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local h;
    
    h := VariableForChernPolynomial( );
    
    return Value( PoincarePolynomial( D ), h ) / (1 + h);
    
end );

##
InstallMethod( LeadingCoefficientOfPoincarePolynomial,
        "for a divisor",
        [ IsDivisor and HasUnderlyingMatroid ],
        
  function( D )
    local M;
    
    M := UnderlyingMatroid( D );
    
    return LeadingCoefficientOfPoincarePolynomial( M );
    
end );

##
InstallMethod( MultiplicityOfConormalToTheOrigin,
        "for a divisor",
        [ IsDivisor and HasUnderlyingMatroid ],
        
  function( D )
    local M, n;
    
    M := UnderlyingMatroid( D );
    
    n := KrullDimension( HomalgRing( D ) );
    
    if RankOfMatroid( M ) < n then
        return 0;
    fi;
    
    return LeadingCoefficientOfPoincarePolynomial( D );
    
end );

##
InstallMethod( MultiplicityOfConormalToTheOrigin,
        "for a divisor",
        [ IsDivisor and HasCharacteristicPolynomial ],
        
  function( D )
    
    return AbsInt( Value( CharacteristicPolynomial( D ), 0 ) );
    
end );

## <Cite Key="Alu13"/> Theorem 4.1: For a locally free arrangement
## <M>c(\mathrm{Der}_{\mathbb{P}^n}(-\log \mathcal{A})) = c_{SM}(\mathbb{P}^n \setminus \mathcal{A})</M>
InstallMethod( ProjectiveChernSchwartzMacPhersonPolynomial,
        "for a divisor complement",
        [ IsDivisor ],
        
  function( D )
    local h, chi, n;
    
    h := VariableForChernPolynomial( );
    
    n := KrullDimension( HomalgRing( D ) ) - 1;
    
    chi := ProjectiveCharacteristicPolynomial( D );
    
    return h^n * Value( chi, 1 + h^-1 );
    
end );

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
InstallMethod( AssociatedMatrix,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return HomalgMatrix( [ DefiningPolynomial( D ) ], 1, 1, HomalgRing( D ) );
        
end );

##
InstallMethod( AssociatedMatrixOverWeylAlgebra,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local A;
    
    A := RingOfDerivations( D );
    
    return A * AssociatedMatrix( D );
    
end );

##
InstallMethod( JacobiMatrix,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local R, var, n, varvec, f;

    R := HomalgRing( D );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        var := RelativeIndeterminatesOfPolynomialRing( R );
    else
        var := Indeterminates( R );
    fi;
    
    n := Length( var );
    
    if not IsBound( R!.DerModule ) then
        R!.DerModule := n * R;
        if IsHomalgGradedRing( R ) then
            ## the good convention below is to give the partials degree -1,
            ## but unfortunately in the theory of hyperplane arrangements
            ## they are given degree 0
            R!.Der0Module := FreeLeftModuleWithDegrees( R, ListWithIdenticalEntries( n, -1 ) );
        fi;
    fi;
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    f := AssociatedMatrix( D );
    
    return Diff( Involution( varvec ), f );
    
end );

##
InstallMethod( DerMinusLogMap,
        "for divisors",
        [ IsDivisor, IsInt ],
        
  function( D, m )
    local map, R, Rn, f, d;
    
    if HasIsPrimeDivisor( D ) and not IsPrimeDivisor( D ) and
       IsBound( D!.PreFactorization ) then
        
        map := List( D!.PreFactorization, P -> DerMinusLogMap( P, m ) );
        
        return Iterated( map, ProductMorphism );
        
    fi;
    
    map := JacobiMatrix( D );
    
    R := HomalgRing( D );
    
    Rn := R!.DerModule;
    
    f := AssociatedMatrix( D );
    
    if IsHomalgGradedRing( R ) then
        ## the good convention is to give the partials degree -1,
        ## but unfortunately in the theory of hyperplane arrangements
        ## they are given degree 0;
        ## for this we use -(d - 1) instead of the correct -d below:
        d := Degree( DefiningPolynomial( D ) );
        map := GradedMap( map, Rn, LeftPresentationWithDegrees( f^m, -(d - 1) ) );
    else
        map := HomalgMap( map, Rn, LeftPresentation( f^m ) );
    fi;
    
    return map;
    
end );

##
InstallMethod( DerMinusLogMap,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return DerMinusLogMap( D, 1 );
    
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
InstallMethod( DerMinusLogMap,
        "for divisors",
        [ IsDivisor and HasPrimeDivisorsAttr, IsList ],
        
  function( D, mu )
    local map;
    
    map := ListN( PrimeDivisorsAttr( D ), mu, {P,m} -> DerMinusLogMap( P, m ) );
    
    return Iterated( map, ProductMorphism );
    
end );

##
InstallMethod( DerMinusLog,
        "for divisors",
        [ IsDivisor and HasIsPrimeDivisor, IsList ],
        
  function( D, mu )
    
    return KernelSubobject( DerMinusLogMap( D, mu ) );
    
end );

##
InstallMethod( DerMinusLog,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return KernelSubobject( DerMinusLogMap( D ) );
    
end );

##
InstallMethod( DerMinusLog0,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    local Der, Jac, A, Theta, R, Rn;
    
    Der := DerMinusLog( D );
    ## FIXME: this is dangerous
    Der := MatrixOfSubobjectGenerators( Der );
    
    Jac := JacobiMatrix( D );
    
    A := Der * Jac;
    
    Theta := SyzygiesGeneratorsOfRows( A );
    
    Theta := Theta * Der;
    
    R := HomalgRing( D );
    
    Rn := R!.Der0Module;
    
    return Subobject( Theta, Rn );
    
end );

##
InstallMethod( Logarithmic1Forms,
        "for divisors",
        [ IsDivisor ],
        
  function( D )
    
    return InternalHom( DerMinusLog0( D ) );
    
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
    local der, A, var;
    
    der := DerMinusLog( D );
    der := MatrixOfGenerators( der );
    
    A := RingOfDerivations( D );
    
    var := IndeterminateDerivationsOfRingOfDerivations( A );
    
    var := HomalgMatrix( var, Length( var ), 1, A );

    der := ( A * der ) * var;
    
    return LeftSubmodule( der );
    
end );

##
InstallMethod( DerMinusLogTildeMatrix,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local der, jac, f, a;
    
    der := DerMinusLog( D );
    der := MatrixOfGenerators( der );
    
    jac := JacobiMatrix( D );
    
    f := AssociatedMatrix( D );
    
    a := RightDivide( der * jac, f );
    
    return UnionOfColumns( -a, der );
    
end );

InstallMethod( DerMinusLogTilde,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    local der;
    
    der := DerMinusLogTildeMatrix( D );
    
    return LeftSubmodule( der );
    
end );

##
InstallMethod( SymmetricAlgebraOfJacobianIdeal,
        "for a divisor and a list of strings",
        [ IsDivisor, IsList ],
        
  function( D, gvar )
    local ann1;
    
    ann1 := DerMinusLogTilde( D );
    
    return SymmetricAlgebraFromSyzygiesObject( ann1, gvar );
    
end );

##
InstallMethod( SymmetricAlgebraOfJacobianIdeal,
        "for a divisor and a string",
        [ IsDivisor, IsString ],
        
  function( D, str )
    local n;
    
    n := Length( Indeterminates( HomalgRing( D ) ) );
    
    str := ParseListOfIndeterminates( SplitString( str, "," ) );
    
    if Length( str ) = 1 and not n = 0 then
        str := str[1];
        str := List( [ 0 .. n ], i -> Concatenation( str, String( i ) ) );
    fi;
    
    return SymmetricAlgebraOfJacobianIdeal( D, str );
    
end );

##
InstallMethod( Annihilator1,
        "for a divisor and a rational number",
        [ IsDivisor, IsRat ],
        
  function( D, lambda )
    local ann1, A, var;
    
    if IsBound( D!.Annihilator1 ) then
        if IsBound( D!.Annihilator1!.(String( lambda )) ) then
            return D!.Annihilator1!.(String( lambda ));
        fi;
    else
        D!.Annihilator1 := rec( );
    fi;
    
    ann1 := DerMinusLogTildeMatrix( D );
    
    A := RingOfDerivations( D );
    
    var := IndeterminateDerivationsOfRingOfDerivations( A );
    
    var := Concatenation( [ lambda ], var );
    
    var := HomalgMatrix( var, Length( var ), 1, A );
    
    ann1 := ( A * ann1 ) * var;
    
    ann1 := LeftSubmodule( ann1 );
    
    D!.Annihilator1!.(String( lambda )) := ann1;
    
    return ann1;
    
end );

##
InstallMethod( Annihilator1,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    
    return Annihilator1( D, -1 );
    
end );
    
##
InstallMethod( Annihilator1Map,
        "for a divisor and a rational number",
        [ IsDivisor, IsRat ],
        
  function( D, lambda )
    local Ann1, A, f;
    
    Ann1 := Annihilator1( D, lambda );
    
    A := HomalgRing( Ann1 );
    
    f := AssociatedMatrixOverWeylAlgebra( D );
    
    return HomalgMap( f, 1 * A, FactorObject( Ann1 ) );
    
end );

##
InstallMethod( KernelSubobject,
        "for a divisor and a rational number",
        [ IsDivisor, IsRat ],
        
  function( D, lambda )
    
    return KernelSubobject( Annihilator1Map( D, lambda ) );
    
end );

##
InstallMethod( Annihilator1Augmented,
        "for a divisor and a rational number",
        [ IsDivisor, IsRat ],
        
  function( D, lambda )
    local f, Ann1f;
    
    if IsBound( D!.Annihilator1Augmented ) then
        if IsBound( D!.Annihilator1Augmented!.(String( lambda )) ) then
            return D!.Annihilator1Augmented!.(String( lambda ));
        fi;
    else
        D!.Annihilator1Augmented := rec( );
    fi;
    
    f := AssociatedMatrixOverWeylAlgebra( D );
    
    Ann1f := LeftSubmodule( f ) + Annihilator1( D, lambda );
    
    D!.Annihilator1Augmented!.(String( lambda )) := Ann1f;
    
    return Ann1f;
    
end );

##
InstallMethod( Annihilator1Augmented,
        "for a divisor, a rational number, and an ideal",
        [ IsDivisor, IsRat, IsHomalgModule and ConstructedAsAnIdeal ],
        
  function( D, lambda, J )
    local Ann1, R;
    
    Ann1 := Annihilator1Augmented( D, lambda );
    
    R := HomalgRing( Ann1 );
        
    return Ann1 + R * J;
    
end );

##
InstallMethod( Annihilator1Augmented,
        "for a divisor, a rational number, and a list of ring elements",
        [ IsDivisor, IsRat, IsList ],
        
  function( D, lambda, J )
    
    return Annihilator1Augmented( D, lambda, LeftSubmodule( J ) );
    
end );

##
InstallMethod( Annihilator1Augmented,
        "for a divisor, a rational number, and a ring element",
        [ IsDivisor, IsRat, IsRingElement ],
        
  function( D, lambda, r )
    
    return Annihilator1Augmented( D, lambda, [ r ] );
    
end );

##
InstallMethod( Annihilator1Augmented,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    
    return Annihilator1Augmented( D, -1 );
    
end );

##
InstallMethod( FirstAffineDegree,
        "for a divisor and a rational number",
        [ IsDivisor, IsRat ],
        
  function( D, lambda )
    local I, d;
    
    I := Annihilator1Augmented( D, lambda );
    
    return AffineDegree( AssociatedGradedModule( I ) );
    
end );

##
InstallMethod( FirstAffineDegree,
        "for a divisor",
        [ IsDivisor ],
        
  function( D )
    
    return FirstAffineDegree( D, -1 );
    
end );

##
InstallMethod( TuttePolynomial,
        "for an arrangement divisor and a ring element",
        [ IsDivisor and HasUnderlyingMatroid, IsRingElement, IsRingElement ],
        
  function( D, x, y )
    local M;
    
    M := UnderlyingMatroid( D );
    
    return TuttePolynomial( M, x, y );
    
end );

##
InstallMethod( CharacteristicPolynomial,
        "for an arrangement divisor and a ring element",
        [ IsDivisor and HasUnderlyingMatroid, IsRingElement ],
        
  function( D, t )
    local M;
    
    M := UnderlyingMatroid( D );
    
    return CharacteristicPolynomial( M, t );
    
end );

##
InstallMethod( PoincarePolynomial,
        "for an arrangement divisor and a ring element",
        [ IsDivisor and HasUnderlyingMatroid, IsRingElement ],
        
  function( D, t )
    local M;
    
    M := UnderlyingMatroid( D );
    
    return PoincarePolynomial( M, t );
    
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
        [ IsHomalgMatrix ],
  function( alpha )
    local n, m, k, matroid, L, R, weights, var, varvec, alphas, alphaH, D;
    
    m := NrRows( alpha );
    n := NrColumns( alpha );
    
    k := HomalgRing( alpha );
    
    alpha := Involution( alpha );
    
    matroid := Matroid( alpha );
    
    L := List( [ 1 .. n ], i -> Concatenation( "x", String( i ) ) );
    
    ## will be graded if k is "graded"
    ## we assume all weights of k to be 0
    if HasAmbientRing( k ) then
        R := AmbientRing( k ) * L;
        R := R / ( R * MatrixOfRelations( k ) );
    else
        R := k * L;
    fi;

    SetRelativeIndeterminatesOfPolynomialRing( R, List( L, x -> x / R ) );
    
    if IsHomalgGradedRing( k ) then
        weights := WeightsOfIndeterminates( k );
        weights := Concatenation( ListWithIdenticalEntries( Length( Indeterminates( k ) ), 0 ), ListWithIdenticalEntries( Length( L ), 1 ) );
        SetWeightsOfIndeterminates( R, weights );
        SetBaseRing( R, k );
    fi;
    
    alpha := R * alpha;
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) or HasAmbientRing( R ) then
        var := RelativeIndeterminatesOfPolynomialRing( R );
    else
        var := IndeterminatesOfPolynomialRing( R );
    fi;
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    alphas := List( [ 1 .. m ], c -> CertainColumns( alpha, [ c ] ) );
    
    alphaH := List( alphas, a -> varvec * a );
    
    alphaH := List( alphaH, a -> EntriesOfHomalgMatrix( a )[ 1 ] );
    
    D := Product( alphaH );
    
    D := Divisor( D );
    
    SetUnderlyingMatroid( D, matroid );
    SetPrimeDivisorsAttr( D, List( alphaH, Divisor ) );
    
    return D;
    
end );

##
InstallMethod( Divisor,
        "constructor for divisors",
        [ IsMatrix, IsHomalgRing ],
  function( A, k )
    local alpha, c, d, n, m, R, var, varvec, alphas, alphaH, D;
    
    alpha := HomalgMatrix( A, k );
    
    alpha := CertainRows( alpha, NonZeroRows( alpha ) );
    
    m := NrRows( alpha );
    n := NrColumns( alpha );
    
    c := Characteristic( k );
    d := DegreeOverPrimeField( k );
    
    if c = 0 then
        if d > 1 then
            Error( "degree > 1 is not supported yet\n" );
        fi;
        A := HOMALG_MATRICES.QQ * alpha;
    else
        A := HomalgRingOfIntegers( c, d ) * alpha;
    fi;
    
    alpha := Involution( alpha );
    
    ## will be graded if k is "graded"
    R := k * List( [ 1 .. n ], i -> Concatenation( "x", String( i ) ) );
    
    alpha := R * alpha;
    
    var := Indeterminates( R );
    
    varvec := HomalgMatrix( var, 1, n, R );
    
    alphas := List( [ 1 .. m ], c -> CertainColumns( alpha, [ c ] ) );
    
    alphaH := List( alphas, a -> varvec * a );
    
    alphaH := List( alphaH, a -> EntriesOfHomalgMatrix( a )[ 1 ] );
    
    D := Product( alphaH );
    
    D := Divisor( D );
    
    SetUnderlyingMatroid( D, Matroid( Involution( A ) ) );
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
InstallOtherMethod( \*,
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
