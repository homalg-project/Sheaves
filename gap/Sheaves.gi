#############################################################################
##
##  Sheaves.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for sheaves.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_SHEAVES_PROJ,
        rec(
            category := rec(
                            description := "coherent sheaves of modules and their morphisms over a projective scheme",
                            short_description := "_for_coherent_sheaves_on_proj",
                            MorphismConstructor := SheafMorphism
                            )
           )
);

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsSheafOfRings

##  <#GAPDoc Label="IsSheafOfRingsOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsSheafOfRingsOnProjRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of &homalg; sheaves of rings. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSheafOfRings"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsStructureObjectOrFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsSheafOfRingsOnProjRep",
        IsSheafOfRings and
        IsStructureObjectOrFinitelyPresentedObjectRep,
        [ "graded_ring" ] );

# a new representation for the GAP-category IsSheafOfModules

##  <#GAPDoc Label="IsCoherentSheafOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsCoherentSheafOnProjRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of coherent sheaves. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSheafOfModules"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsStaticFinitelyPresentedObjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCoherentSheafOnProjRep",
        IsSheafOfModules and
        IsStaticFinitelyPresentedObjectRep,
        [ "GradedModuleModelingTheSheaf" ] );

##  <#GAPDoc Label="IsCoherentSubsheafOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsCoherentSubsheafOnProjRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of coherent sheaves. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsSheafOfModules"/>,
##       which is a subrepresentation of the &GAP; representation
##      <C>IsStaticFinitelyPresentedSubobjectRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsCoherentSubsheafOnProjRep",
        IsSheafOfModules and
        IsStaticFinitelyPresentedSubobjectRep,
        [ "map_having_subobject_as_its_image" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfSheavesOfRings",
        NewFamily( "TheFamilyOfSheavesOfRings" ) );

# a new type:
BindGlobal( "TheTypeSheafOfRings",
        NewType( TheFamilyOfSheavesOfRings,
                IsSheafOfRingsOnProjRep ) );

# a new family:
BindGlobal( "TheFamilyOfHomalgSheaves",
        NewFamily( "TheFamilyOfHomalgSheaves" ) );

# two new types:
BindGlobal( "TheTypeHomalgLeftCoherentSheaf",
        NewType( TheFamilyOfHomalgSheaves,
                IsCoherentSheafOnProjRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightCoherentSheaf",
        NewType( TheFamilyOfHomalgSheaves,
                IsCoherentSheafOnProjRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for sheaves",
        [ IsSheafOfModules and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( E )
    
    return LeftActingDomain( E );
    
end );

##
InstallMethod( StructureSheafOfAmbientSpace,
        "for sheaves",
        [ IsSheafOfModules and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( E )
    
    return RightActingDomain( E );
    
end );

##
InstallMethod( StructureObject,
        "for homalg modules",
        [ IsSheafOfModules ],
        
  function( M )
    
    return StructureSheafOfAmbientSpace( M );
    
end );

##
InstallMethod( DimensionOfAmbientSpace,
        "for sheaves of rings",
        [ IsSheafOfModules ],
        
  function( E )
    
    return Dimension( StructureSheafOfAmbientSpace( E ) );
    
end );

##
InstallMethod( HomalgRing,
        "for sheaves of rings",
        [ IsSheafOfRings ],
        
  function( O )
    
    if IsBound(O!.graded_ring) then
        return O!.graded_ring;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgRing,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    return HomalgRing( StructureSheafOfAmbientSpace( E ) );
    
end );

##
InstallMethod( AsLeftObject,
        "for homalg sheaf of rings",
        [ IsSheafOfRings ],
        
  function( R )
    local left;
    
    if IsBound(R!.AsLeftObject) then
        return R!.AsLeftObject;
    fi;
    
    left := Sheafify( 1 * HomalgRing( R ) );
    
    left!.distinguished := true;
    
    left!.not_twisted := true;
    
    R!.AsLeftObject := left;
    
    return left;
    
end );

##
InstallMethod( AsRightObject,
        "for homalg sheaf of rings",
        [ IsSheafOfRings ],
        
  function( R )
    local right;
    
    if IsBound(R!.AsRightObject) then
        return R!.AsRightObject;
    fi;
    
    right := Sheafify( HomalgRing( R ) * 1 );
    
    right!.distinguished := true;
    
    right!.not_twisted := true;
    
    R!.AsRightObject := right;
    
    return right;
    
end );

##
InstallMethod( UnderlyingGradedModule,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    
    if HasTruncatedModuleOfGlobalSections( E ) then;
        return TruncatedModuleOfGlobalSections( E );
    fi;
    
    return E!.GradedModuleModelingTheSheaf;
    
end );

##
InstallMethod( HasCurrentResolution,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],

  function( F )
    local M, p;
    
    M := UnderlyingGradedModule( F );
    
    p := PositionOfTheDefaultPresentation( M );
    
    return 
        HasCurrentResolution( M ) and 
        IsBound( F!.Resolutions ) and
        IsBound( F!.Resolutions!.(p) ) and 
        IsIdenticalObj( Cokernel( LowestDegreeMorphism( F!.Resolutions!.(p) ) ), M );

end );

##
InstallMethod( SetCurrentResolution,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep, IsHomalgComplex ],

  function( F, sheaf_res )

    if not IsBound( F!.Resolutions ) then
        F!.Resolutions := rec( );
    fi;
    
    F!.Resolutions!.(PositionOfTheDefaultPresentation( UnderlyingGradedModule( F ) ) ) := sheaf_res;

end );

##
InstallMethod( CurrentResolution,
        "for sheaves of modules on proj",
        [ IsInt, IsCoherentSheafOnProjRep ],
        
  function( q, F )
  local res, degrees, deg, len, CEpi, d_j, F_j, sheaf_res, j;
    
    res := Resolution( q, UnderlyingGradedModule( F ) );
    degrees := ObjectDegreesOfComplex( res );
    len := Length( degrees );
    
    if HasCurrentResolution( F ) then
        sheaf_res := CurrentResolution( F );
        deg := ObjectDegreesOfComplex( sheaf_res );
        j := Length( deg );
        j := deg[j];
        d_j := CertainMorphism( sheaf_res, j );
    else
        j := res!.degrees[2];
        CEpi := SheafMorphism( CokernelEpi( res!.(j) ), "create", F );
        d_j := SheafMorphism( res!.(j), "create", Source( CEpi ) );
        SetCokernelEpi( d_j, CEpi );
        sheaf_res := HomalgComplex( d_j );
        SetCurrentResolution( F, sheaf_res ); #we possibly overwrite the CurrentResolution of the module which is not build from global sections
    fi;

    F_j := Source( d_j );
    
    if len >= j+2 then
        for j in [ res!.degrees[j+2] .. res!.degrees[len] ] do
#             if IsIdenticalObj( F_j, 0 * S ) or IsIdenticalObj( F_j, S * 0 ) then
#                 # take care not to create the graded zero morphism between distinguished zero modules again each step
#                 d_j := TheZeroMorphism( F_j, F_j );
#                 Add( sheaf_res, d_j );
#                 # no need for resetting F_j, since all other modules will be zero, too
#             else
                d_j := SheafMorphism( res!.(j), "create", F_j );
                Add( sheaf_res, d_j );
                F_j := Source( d_j );
#             fi;
        od;
    fi;

    if HasIsAcyclic( res ) and IsAcyclic( res ) then
        SetIsAcyclic( sheaf_res, true );
    fi;
    if HasIsRightAcyclic( res ) and HasIsRightAcyclic( res ) then
        SetIsRightAcyclic( sheaf_res, true );
    fi;
    
    if IsBound( res!.LengthOfResolution ) then
        sheaf_res!.LengthOfResolution := res!.LengthOfResolution;
    fi;
    
    return sheaf_res;
    
end );

##
InstallMethod( Resolution,
        "for homalg modules",
        [ IsInt, IsCoherentSheafOnProjRep ],

  function( _q, F )
    local q, d, rank;

    if _q < 0 then
        F!.MaximumNumberOfResolutionSteps := BoundForResolution( F );
        q := _q;
    elif _q = 0 then
        q := 1;         ## this is the minimum
    else
        q := _q;
    fi;

    d := CurrentResolution( q, F );

    return d;

end );

##
InstallMethod( GlobalSections,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local M, p, Gamma;
    
    M := UnderlyingGradedModule( E );
    
    p := PositionOfTheDefaultSetOfGenerators( M );
    
    ## the caching
    if IsBound( E!.GlobalSections ) then
        Gamma := E!.GlobalSections;
        if IsIdenticalObj( M, Gamma[1] ) and p = Gamma[2] then
            return Gamma[3];
        fi;
    fi;
    
    Assert( 1, 0 >= CastelnuovoMumfordRegularity( M ) );
    
    Gamma := HomogeneousPartOverCoefficientsRing( 0, M );
    
    ## save the global sections with context
    E!.GlobalSections := [ M, p, Gamma ];
    
    ## and save the sheaf in the global sections module (thanks GAP)
    Gamma!.GlobalSectionsOfTheSheaf := E;
    
    return Gamma;
    
end );

##
InstallMethod( InducedMorphismToProjectiveSpace,
        "for sheaves",
        [ IsSheafOfModules ],
        
  function( E )
    local Gamma, D;
    
    Gamma := GlobalSections( E );
    
    D := AsLinearSystem( Gamma );
    
    return InducedMorphismToProjectiveSpace( D );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( StructureSheafOfProj,
        "constructor for structure sheaves",
        [ IsHomalgGradedRingRep and ContainsAField ],
        
  function( S )
    local O, J;
    
    O := rec( graded_ring := S );
    
    ObjectifyWithAttributes(
            O, TheTypeSheafOfRings
            );
    
    if HasDefiningIdeal( S ) then
        J := DefiningIdeal( S );
        SetIdealSheaf( O, Sheafify( J ) );
        SetAsModuleOverStructureSheafOfAmbientSpace( O, Sheafify( FactorObject( J ) ) );
    fi;
    
    if HasKrullDimension( S ) then
       SetDimension( O, KrullDimension( S ) - 1 );
    fi;
    
    return O;
    
end );

##
InstallMethod( Sheafify,
        "constructor for coherent sheaves over a projective scheme",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  Proj );

##
InstallMethod( Proj,
        "constructor for coherent sheaves over a projective scheme",
        [ IsGradedModuleOrGradedSubmoduleRep ],
        
  function( M )
    local S, O, E;
    
    S := HomalgRing( M );
    
    O := StructureSheafOfProj( S );
    
    E := rec(
             GradedModuleModelingTheSheaf := M,
             string := "sheaf", string_plural := "sheaves"
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        
        ObjectifyWithAttributes(
                E, TheTypeHomalgLeftCoherentSheaf,
                LeftActingDomain, O );
        
    else
        
        ObjectifyWithAttributes(
                E, TheTypeHomalgRightCoherentSheaf,
                RightActingDomain, O );
        
    fi;
    
    return E;
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRingRep ],
        
  function( mat, weights, S )
    local M;
    
    M := LeftPresentationWithDegrees( mat, weights, S );
    
    return Sheafify( M );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep, IsList ],
        
  function( mat, weights )
    
    return LeftSheaf( mat, weights, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, weight, S )
    
    return LeftSheaf( mat, ListWithIdenticalEntries( NrColumns( mat ), weight ), S );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep, IsInt ],
        
  function( mat, weight )
    
    return LeftSheaf( mat, weight, HomalgRing( mat ) );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return LeftSheaf( mat, ListWithIdenticalEntries( NrColumns( mat ), 0 ), S );
    
end );

##
InstallMethod( LeftSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep ],
        
  function( mat )
    
    return LeftSheaf( mat, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix, IsList, IsHomalgGradedRingRep ],
        
  function( mat, weights, S )
    local M;
    
    M := RightPresentationWithDegrees( mat, weights, S );
    
    return Sheafify( M );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep, IsList ],
        
  function( mat, weights )
    local M;
    
    return RightSheaf( mat, weights, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix, IsInt, IsHomalgGradedRingRep ],
        
  function( mat, weight, S )
    
    return RightSheaf( mat, ListWithIdenticalEntries( NrRows( mat ), weight ), S );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep, IsInt ],
        
  function( mat, weight )
    
    return RightSheaf( mat, weight, HomalgRing( mat ) );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgMatrix, IsHomalgGradedRingRep ],
        
  function( mat, S )
    
    return RightSheaf( mat, ListWithIdenticalEntries( NrRows( mat ), 0 ), S );
    
end );

##
InstallMethod( RightSheaf,
        "constructor",
        [ IsHomalgHomogeneousMatrixRep ],
        
  function( mat )
    
    return RightSheaf( mat, HomalgRing( mat ) );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( R, weights )
    
    return LeftPresentationWithDegrees( HomalgZeroMatrix( 0, Length( weights ), R ), weights );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsInt, IsHomalgGradedRingRep, IsInt ],
        
  function( rank, R, weight )
    
    return DirectSumOfLeftLineBundles( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( DirectSumOfLeftLineBundles,
        "constructor",
        [ IsInt, IsHomalgGradedRingRep ],
        
  function( rank, R )
    
    return DirectSumOfLeftLineBundles( rank, R, 0 );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsHomalgGradedRingRep, IsList ],
        
  function( R, weights )
    
    return RightPresentationWithDegrees( HomalgZeroMatrix( Length( weights ), 0, R ), weights );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsInt, IsHomalgGradedRingRep, IsInt ],
        
  function( rank, R, weight )
    
    return DirectSumOfRightLineBundles( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( DirectSumOfRightLineBundles,
        "constructor",
        [ IsInt, IsHomalgGradedRingRep ],
        
  function( rank, R )
    
    return DirectSumOfRightLineBundles( rank, R, 0 );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsSheafOfRings, IsInt ],
        
  function( R, twist )
    
    return DirectSumOfLeftLineBundles( 1, R, -twist );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsSheafOfRings, IsList ],
        
  function( R, twist )
    
    return DirectSumOfLeftLineBundles( R, -twist );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for sheaves of rings",
        [ IsSheafOfRingsOnProjRep ],
        
  function( O )
    local S, weights;
    
    S := HomalgRing( O );
    
    if S <> fail then
        
        if HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
            
            Print( "<The structure sheaf of some ", Dimension( O ), "-dimensional " );
            
            weights := WeightsOfIndeterminates( S );
            
            if Set( weights ) <> [ 1 ] then
                
                weights := String( weights );
                
                RemoveCharacters( weights, "\[\] " );
                
                Print( "(", weights, ")-weighted " );
                
            fi;
            
            Print( "projective space>" );
            
        else
            
            Print( "<A sheaf of rings>" );
            
        fi;
        
    else
        
        Print( "<A sheaf of rings>" );
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for coherent sheaves",
        [ IsCoherentSheafOnProjRep ],
        
  function( E )
    local O, S, weights, is_subobject, M, R, left_sheaf, properties, nz;
    
    O := StructureSheafOfAmbientSpace( E );
    
    S := HomalgRing( O );
    
    is_subobject := IsStaticFinitelyPresentedSubobjectRep( E );
    
    if is_subobject then
        M := UnderlyingObject( E );
        if HasIsFree( M ) and IsFree( M ) then
            SetIsFree( E, true );
            ViewObj( E );
            return;
        elif HasIsZero( M ) and IsZero( M ) then
            SetIsZero( E, true );
            ViewObj( E );
            return;
        fi;
    else
        M := E;
    fi;
    
    left_sheaf := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    properties := "";
    
    if HasIsStablyFree( M ) and IsStablyFree( M ) then
        Append( properties, " stably free" );
        if HasIsFree( M ) and not IsFree( M ) then	## the "not"s are obsolete but kept for better readability
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsDirectSumOfLineBundles( M ) and IsDirectSumOfLineBundles( M ) then
        if HasRankOfSheaf( M ) and RankOfSheaf( M ) = 1 then
            Append( properties, " invertible" );
        else
            Append( properties, " direct sum of line bundles" );
        fi;
        if HasIsFree( M ) and not IsFree( M ) then	## the "not"s are obsolete but kept for better readability
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsLocallyFree( M ) and IsLocallyFree( M ) then
        Append( properties, " locally free" );
        if HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsReflexive( M ) and IsReflexive( M ) then
        Append( properties, " reflexive" );
        if HasIsLocallyFree( M ) and not IsLocallyFree( M ) then
            Append( properties, " non-locally free" );
            nz := true;
        elif HasIsStablyFree( M ) and not IsStablyFree( M ) then
            Append( properties, " non-stably free" );
            nz := true;
        elif HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        if HasCodegreeOfPurity( M ) then
            if CodegreeOfPurity( M ) = [ 1 ] then
                Append( properties, Concatenation( " codegree-", String( 1 ), "-pure" ) );
            else
                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-pure" ) );
            fi;
            if not ( HasRankOfSheaf( M ) and RankOfSheaf( M ) > 0 ) then
                Print( " torsion-free" );
            fi;
            nz := true;
        else
            Append( properties, " torsion-free" );
            if HasIsReflexive( M ) and not IsReflexive( M ) then
                Append( properties, " non-reflexive" );
                nz := true;
            elif HasIsLocallyFree( M ) and not IsLocallyFree( M ) then
                Append( properties, " non-projective" );
                nz := true;
            elif HasIsFree( M ) and not IsFree( M ) then
                Append( properties, " non-free" );
                nz := true;
            fi;
        fi;
    fi;
    
    if HasIsTorsion( M ) and IsTorsion( M ) then
        if HasGrade( M ) then
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the ambient space has dimension > 1:
                    if not Dimension( O ) <= 1 then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            fi;
            Append( properties, " depth " );
            Append( properties, String( Grade( M ) ) );
        else
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the global dimension of the ring is > 1:
                    if not ( left_sheaf and HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 ) and
                       not ( not left_sheaf and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 ) then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            elif HasIsZero( M ) and not IsZero( M ) then
                properties := Concatenation( " non-zero", properties );
            fi;
            Append( properties, " torsion" );
        fi;
    else
        if HasIsPure( M ) and not IsPure( M ) then
            Append( properties, " non-pure" );
        fi;
        if HasRankOfSheaf( M ) then
            Append( properties, " rank " );
            Append( properties, String( RankOfSheaf( M ) ) );
        elif HasIsZero( M ) and not IsZero( M ) and
          not ( HasIsPure( M ) and not IsPure( M ) ) and
          not ( IsBound( nz ) and nz = true ) then
            properties := Concatenation( " non-zero", properties );
        fi;
    fi;
    
    if left_sheaf then
        
        if is_subobject then
            if IsIdenticalObj( SuperObject( E ), 1 * S ) then
                Print( "<A", properties, " coherent sheaf of (left) ideals" );
            else
                Print( "<A", properties, " coherent subsheaf of (left) modules" );
            fi;
        else
            Print( "<A", properties, " coherent sheaf of (left) modules" );
        fi;
        
    else
        
        if is_subobject then
            if IsIdenticalObj( SuperObject( E ), S * 1 ) then
                Print( "<A", properties, " coherent sheaf of (right) ideals" );
            else
                Print( "<A", properties, " coherent subsheaf of (right) modules" );
            fi;
        else
            Print( "<A", properties, " coherent sheaf of (right) modules" );
        fi;
        
    fi;
    
    if S <> fail then
        
        if HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
            
            Print( " on some ", Dimension( O ), "-dimensional " );
            
            weights := WeightsOfIndeterminates( S );
            
            if Set( weights ) <> [ 1 ] then
                
                weights := String( weights );
                
                RemoveCharacters( weights, "\[\] " );
                
                Print( "(", weights, ")-weighted " );
                
            fi;
            
            Print( "projective space" );
            
        fi;
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for free sheaves",
        [ IsCoherentSheafOnProjRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( M )
    local r, rk;
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    Print( " free sheaf of " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " modules" );
    
    r := NrGenerators( M );
    
    if HasRankOfSheaf( M ) then
        rk := RankOfSheaf( M );
        Print( " of rank ", rk );
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( ViewObj,
        "for zero sheaves",
        [ IsCoherentSheafOnProjRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( M )
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    Print( " zero sheaf of " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " modules>" );
    
end );
    
##
InstallMethod( homalgProjString,
        "for sheaves of rings",
        [ IsHomalgGradedRing and IsFreePolynomialRing ],
        
  function( S )
    local proj, weights;
    
    proj := "O_P";
    
    Append( proj, String( Length( Indeterminates( S ) ) - 1 ) );
    
    weights := WeightsOfIndeterminates( S );
    
    if Set( weights ) <> [ 1 ] then
        
        weights := String( weights );
        
        RemoveCharacters( weights, "\[\] " );
        
        Append( proj, Concatenation( "(", weights, ")" ) );
        
    fi;
    
    return proj;
    
end );

##
InstallMethod( Display,
        "for sheaves of rings",
        [ IsSheafOfRingsOnProjRep ],
        
  function( O )
    local S, weights;
    
    S := HomalgRing( O );
    
    if S <> fail then
        
        if HasIsFreePolynomialRing( S ) and IsFreePolynomialRing( S ) then
            
            Print( homalgProjString( S ) );
            
        else
            
            Print( "no display method found" );
            
        fi;
        
    else
        
        Print( "no display method found" );
        
    fi;
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for sheaves of rings",
        [ IsCoherentSheafOnProjRep ],
        
  function( E )
    
    Display( UnderlyingGradedModule( E ) );
    
end );

