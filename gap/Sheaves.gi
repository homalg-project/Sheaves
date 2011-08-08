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
                            MorphismConstructor := SheafMorphism,
                            InternalHom := SheafHom,
                            InternalExt := SheafExt,
                            TryPostDivideWithoutAids := true, # see homalg/ToolFunctors.gi
                            ),
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

# new representations for the GAP-category IsSheafOfModules

##  <#GAPDoc Label="IsCoherentSheafOrSubsheafOnProjRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsCoherentSheafOrSubsheafOnProjRep"/>
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
DeclareRepresentation( "IsCoherentSheafOrSubsheafOnProjRep",
        IsSheafOfModules and
        IsStaticFinitelyPresentedObjectOrSubobjectRep,
        [ ] );

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
        IsCoherentSheafOrSubsheafOnProjRep and
        IsStaticFinitelyPresentedObjectRep,
        [
          "SetOfUnderlyingModules",
          "ListOfKnownUnderlyingModules",
          "PositionOfTheDefaultPresentation" 
         ] );

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
        IsCoherentSheafOrSubsheafOnProjRep and
        IsStaticFinitelyPresentedSubobjectRep,
        [
          "SetOfUnderlyingModules",
          "ListOfKnownUnderlyingModules",
          "PositionOfTheDefaultPresentation",
          "map_having_subobject_as_its_image"
         ] );

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
InstallMethod( CheckHasTruncatedModuleOfGlobalSections,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep, IsGradedModuleOrGradedSubmoduleRep ],
        
  function( E, M )
    local HM;
    
    if not HasTruncatedModuleOfGlobalSections( E ) then
    
        if ( HasIsModuleOfGlobalSections( M ) and IsModuleOfGlobalSections( M ) ) then
            SetTruncatedModuleOfGlobalSections( E, M );
            return true;
        else
            HM := GetFunctorObjCachedValue( Functor_ModuleOfGlobalSections_ForGradedModules, [ M ] );
            if HM <> fail then
                AddANewPresentation( E, HM );
                SetTruncatedModuleOfGlobalSections( E, HM );
                HM!.Proj := E;
                return true;
            fi;
        fi;
    fi;
    
    return false;
    
end );

##
InstallMethod( AddANewPresentation,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep, IsGradedModuleRep ],
        
  function( F, M )
    local modules, l;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) )
       and not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRightObjectOrMorphismOfRightObjects( F ) ) then
        Error( "the sheaf and the new presentation module must either be both left or both right\n" );
    fi;
    
    modules := F!.SetOfUnderlyingModules;
    
    l := F!.ListOfKnownUnderlyingModules[ Length( F!.ListOfKnownUnderlyingModules ) ];
    
    ## define the (l+1)st set of generators:
    modules!.(l+1) := M;
    
    ## adjust the list of positions:
    F!.ListOfKnownUnderlyingModules[ l+1 ] := l+1; ## the list is allowed to contain holes (sparse list)
    
    ## adjust the default position:
    if IsLockedObject( F ) then
        F!.LockObjectOnCertainPresentation := [ l+1, PositionOfTheDefaultPresentation( M ) ];
    else
        SetPositionOfTheDefaultPresentation( F, [ l+1, PositionOfTheDefaultPresentation( M ) ] );
    fi;
    
    return F;
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep, IsList ],
        
  function( M, p )
    
    ## first save the current setting
    M!.LockObjectOnCertainPresentation := PositionOfTheDefaultPresentation( M );
    
    SetPositionOfTheDefaultPresentation( M, p );
    
    LockObjectOnCertainPresentation( UnderlyingGradedModule( M ), p[2] );
    
end );

##
InstallMethod( LockObjectOnCertainPresentation,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( M )
    
    LockObjectOnCertainPresentation( M, PositionOfTheDefaultPresentation( M ) );
    
end );

##
InstallMethod( UnlockObject,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( M )
    
    UnlockObject( UnderlyingGradedModule( M ) );
    
    ## first restore the saved settings
    if IsBound( M!.LockObjectOnCertainPresentation ) then
        SetPositionOfTheDefaultPresentation( M, M!.LockObjectOnCertainPresentation );
        Unbind( M!.LockObjectOnCertainPresentation );
    fi;
    
end );

##
InstallMethod( IsLockedObject,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( M )
    
    return IsBound( M!.LockObjectOnCertainPresentation );
    
end );

##
InstallMethod( PartOfPresentationRelevantForOutputOfFunctors,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep, IsList ],
        
  function( F, l )
    
    if not ( Length( l ) = 2 and IsPosInt( l[1] ) and IsPosInt( l[2] ) ) and l[1] in F!.ListOfKnownUnderlyingModules then
        Error( "unknown presentation" );
    fi;
    
    return F!.SetOfUnderlyingModules!.(l[1]);
    
end );

##
InstallMethod( PresentationMorphism,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return SheafMorphism( PresentationMorphism( UnderlyingGradedModule( F ) ), "create", "create" );
    
end );

##
InstallMethod( SyzygiesObjectEpi,
        "for sheaves of modules on proj",
        [ IsInt, IsCoherentSheafOnProjRep ],
        
  function( q, M )
    local d, mu, epi, mat;
    
    if q < 0 then
        Error( "a negative integer does not make sense\n" );
    elif q = 0 then
        return CokernelEpi( FirstMorphismOfResolution( M ) );
    fi;
    
    d := Resolution( q, M );
    
    mu := SyzygiesObjectEmb( q, M );
    
    epi := CertainMorphism( d, q ) / mu;  ## lift
    
    SetIsEpimorphism( epi, true );
    
    return epi;
    
end );

##
InstallMethod( CheckIfTheyLieInTheSameCategory,
        "for two (sub)sheaves of modules on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep, IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( F, G )
    
    if AssertionLevel( ) >= HOMALG.AssertionLevel_CheckIfTheyLieInTheSameCategory then
        if not IsIdenticalObj( HomalgRing( UnderlyingGradedModule( F ) ), HomalgRing( UnderlyingGradedModule( G ) ) ) then
            Error( "the rings of the two underlying (sub)modules are not identical\n" );
        elif not ( ( IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) and
                IsHomalgLeftObjectOrMorphismOfLeftObjects( G ) ) or
                ( IsHomalgRightObjectOrMorphismOfRightObjects( F ) and
                  IsHomalgRightObjectOrMorphismOfRightObjects( G ) ) ) then
            Error( "the two (sub)sheaves must either be both left or both right (sub)sheaves\n" );
        fi;
    fi;
    
end );

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
    local pos;
    
    pos := E!.PositionOfTheDefaultPresentation;
    
    return E!.SetOfUnderlyingModules!.(pos);
    
    
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
        IsIdenticalObj( Cokernel( LowestDegreeMorphism( F!.Resolutions!.(p) ) ), F );

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
        [ IsCoherentSheafOnProjRep ],

  function( F )
    
    return F!.Resolutions!.(PositionOfTheDefaultPresentation( UnderlyingGradedModule( F ) ) );

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
        Assert( 2, IsMorphism( CEpi ) );
        SetIsMorphism( CEpi, true );
        Assert( 2, IsEpimorphism( CEpi ) );
        SetIsEpimorphism( CEpi, true );
        d_j := SheafMorphism( res!.(j), "create", Source( CEpi ) );
        Assert( 2, IsMorphism( d_j ) );
        SetIsMorphism( d_j, true );
        SetCokernelEpi( d_j, CEpi );
        sheaf_res := HomalgComplex( d_j );
        SetCurrentResolution( F, sheaf_res ); #we possibly overwrite the CurrentResolution of the module which is not build from global sections
    fi;
    
    F!.res := true;

    F_j := Source( d_j );
    
    if len >= j+2 then
        for j in [ res!.degrees[j+2] .. res!.degrees[len] ] do
            if IsBound( F_j!.distinguished ) and F_j!.distinguished and HasIsZero( UnderlyingGradedModule( F_j ) ) and IsZero( UnderlyingGradedModule( F_j ) ) then
                # take care not to create the graded zero morphism between distinguished zero modules again each step
                d_j := TheZeroMorphism( F_j, F_j );
                Add( sheaf_res, d_j );
                # no need for resetting F_j, since all other modules will be zero, too
            else
                d_j := SheafMorphism( res!.(j), "create", F_j );
                Assert( 2, IsMorphism( d_j ) );
                SetIsMorphism( d_j, true );
                Add( sheaf_res, d_j );
                F_j := Source( d_j );
            fi;
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
        "for sheaves of modules on proj",
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

# this method is used in Resolution for short exact (co)sequences.
# It chooses a module presentating F as the image of the graded
# modulehomomorphism induced by psi. since psi is assumed to be
# surjective (as morphism of sheaves) the cokernel of the underlying
# graded module map is artinian. we compute a resolution of the module
# and sheafify it. This has the advantage, that the underlying graded
# map of phi is surjective and we can compute a PostDivide of 
# psi and the CoveringEpi of M.
##
InstallMethod( ResolutionWithRespectToMorphism,
        "for sheaves of modules on proj",
        [ IsInt, IsCoherentSheafOnProjRep, IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( q, F, psi )
    local psi2, res2, CEpi, d_j, res, F_j, j;
    
    psi2 := UnderlyingGradedMap( psi );
    
    if HasIsEpimorphism( psi2 ) and IsEpimorphism( psi2 ) then
        return Resolution( q, F );
    fi;
    
    res2 := Resolution( q, ImageObject( psi2 ) );
    
    CEpi := SheafMorphism( PreCompose( CokernelEpi( CertainMorphism( res2, 1 ) ), ImageObjectEmb( psi2 ) ), "create", F );
    Assert( 2, IsMorphism( CEpi ) );
    SetIsMorphism( CEpi, true );
    Assert( 2, IsEpimorphism( CEpi ) );
    SetIsEpimorphism( CEpi, true );
    
    d_j := SheafMorphism( CertainMorphism( res2, 1 ), "create", Source( CEpi ) );
    Assert( 2, IsMorphism( d_j ) );
    SetIsMorphism( d_j, true );
    SetCokernelEpi( d_j, CEpi );
    
    res := HomalgComplex( d_j );
    F_j := Source( d_j );
    
    for j in [ 2 .. q ] do
        if IsBound( F_j!.distinguished ) and F_j!.distinguished and HasIsZero( UnderlyingGradedModule( F_j ) ) and IsZero( UnderlyingGradedModule( F_j ) ) then
            # take care not to create the graded zero morphism between distinguished zero modules again each step
            d_j := TheZeroMorphism( F_j, F_j );
            Add( res, d_j );
            # no need for resetting F_j, since all other modules will be zero, too
        else
            d_j := SheafMorphism( CertainMorphism( res2, j ), "create", F_j );
            Assert( 2, IsMorphism( d_j ) );
            SetIsMorphism( d_j, true );
            Add( res, d_j );
            F_j := Source( d_j );
        fi;
    od;

    if HasIsAcyclic( res2 ) and IsAcyclic( res2 ) then
        SetIsAcyclic( res, true );
    fi;
    if HasIsRightAcyclic( res2 ) and HasIsRightAcyclic( res2 ) then
        SetIsRightAcyclic( res, true );
    fi;
    
    #we possibly overwrite a "better" CurrentResolution of the sheaf_res
    #but setting this is vital for the Cartan-Eilenberg-resolution
    SetCurrentResolution( F, res );
    
    return res;
    
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
    
    if IsBound( S!.StructureSheafOfProj ) then
        return S!.StructureSheafOfProj;
    fi;
    
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
    
    S!.StructureSheafOfProj := 0;
    
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
    
    if IsBound( M!.distinguished ) and M!.distinguished and HasIsZero( M ) and IsZero( M ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            if IsBound( O!.ZeroLeftSheaf ) then
                return O!.ZeroLeftSheaf;
            fi;
        else
            if IsBound( O!.ZeroRightSheaf) then
                return O!.ZeroRightSheaf;
            fi;
        fi;
    fi;
    
    if IsBound( M!.Proj ) then
        return M!.Proj;
    fi;
    
    E := rec(
        SetOfUnderlyingModules := rec(
            1 := M
        ),
        ListOfKnownUnderlyingModules := [ 1 ],
        PositionOfTheDefaultPresentation := 1,
        category := HOMALG_SHEAVES_PROJ.category,
        string := "sheaf",
        string_plural := "sheaves"
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
    
    if IsBound( M!.distinguished ) and M!.distinguished and HasIsZero( M ) and IsZero( M ) then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            E!.distinguished := true;
            O!.ZeroLeftSheaf := E;
        else
            E!.distinguished := true;
            O!.ZeroRightSheaf := E;
        fi;
    fi;
    
    M!.Proj := E;
    
#     CheckHasTruncatedModuleOfGlobalSections( E, M );
    
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
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
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
        [ IsHomalgMatrixOverGradedRingRep, IsInt ],
        
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
        [ IsHomalgMatrixOverGradedRingRep ],
        
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
        [ IsHomalgMatrixOverGradedRingRep, IsList ],
        
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
        [ IsHomalgMatrixOverGradedRingRep, IsInt ],
        
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
        [ IsHomalgMatrixOverGradedRingRep ],
        
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
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( E )
    local O, S, weights, is_subobject, M, R, left_sheaf, properties, nz;
    
    O := StructureSheafOfAmbientSpace( E );
    
    S := HomalgRing( O );
    
    is_subobject := IsCoherentSubsheafOnProjRep( E );
    
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
    
    if IsLockedObject( M ) then
        Append( properties, " (locked)" );
    fi;
    
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
        [ IsCoherentSheafOrSubsheafOnProjRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( M )
    local sub, r, rk;
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    if IsCoherentSubsheafOnProjRep( M ) then
        sub := "sub";
    else
        sub := "";
    fi;
    
    Print( " free ", sub, "sheaf of " );
    
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
        [ IsCoherentSheafOrSubsheafOnProjRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( M )
    local sub;
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    if IsCoherentSubsheafOnProjRep( M ) then
        sub := "sub";
    else
        sub := "";
    fi;
    
    Print( " zero ", sub, "sheaf of " );
    
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
        "for coherent sheaves on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  function( E )
    
    Display( UnderlyingGradedModule( E ) );
    
    if HasTruncatedModuleOfGlobalSections( E ) then
        Print( "a sheaf modeled by the above truncated graded module of global sections\n" );
    else
        Print( "a sheaf modeled by the above graded module\n" );
    fi;
    
end );

