#############################################################################
##
##  BasicFunctors.gi                                         Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## Cokernel
##

##
InstallGlobalFunction( _Functor_Cokernel_OnCoherentSheafOnProj, ### defines: Cokernel(Epi)
  function( phi )
    local psi, coker_psi, nat, epi, coker, gen_iso, img_emb, emb;
    
    if HasCokernelEpi( phi ) then
      return Range( CokernelEpi( phi ) );
    fi;
    
    psi := UnderlyingGradedMap( phi );
    
    coker_psi := Cokernel( psi );

    ## the generalized inverse of the natural epimorphism
    ## (cf. [Bar, Cor. 4.8])
    gen_iso := GeneralizedMorphism(
        SheafMorphism( GeneralizedInverse( CokernelEpi( psi ) ), "create", Range( phi ) ),
        phi );
    
    coker := Source( gen_iso );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsGeneralizedIsomorphism( gen_iso, true );
    
    epi := SheafMorphism( CokernelEpi( psi ), Range( phi ), coker );
    
    ## set the attribute CokernelEpi (specific for Cokernel):
    SetCokernelEpi( phi, epi );
    
    ## set the generalized inverse of the natural epimorphism
    SetGeneralizedInverse( epi, gen_iso );
    
    #=====# end of the core procedure #=====#
    
    ## abelian category: [HS, Prop. II.9.6]
    if HasImageObjectEmb( phi ) then
        img_emb := ImageObjectEmb( phi );
        SetKernelEmb( epi, img_emb );
        if not HasCokernelEpi( img_emb ) then
            SetCokernelEpi( img_emb, epi );
        fi;
    elif HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
        SetKernelEmb( epi, phi );
    fi;
    
    ## this is in general NOT a morphism,
    ## BUT it is one modulo the image of phi in T, and then even a monomorphism:
    ## this is enough for us since we will always view it this way (cf. [BR08, 3.1.1,(2), 3.1.2] )
    emb := GeneralizedMorphism(
        SheafMorphism( NaturalGeneralizedEmbedding( coker_psi ), coker, Range( phi ) ),
        phi );
    
    ## we cannot check this assertion, since
    ## checking it would cause an infinite loop
    SetIsGeneralizedIsomorphism( emb, true );
    
    ## save the natural embedding in the cokernel (thanks GAP):
    coker!.NaturalGeneralizedEmbedding := emb;
    
    return coker;
    
end );

##  <#GAPDoc Label="functor_Cokernel:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_Cokernel_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "Cokernel" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "Cokernel" ],
                [ "natural_transformation", "CokernelEpi" ],
                [ "special", true ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMorphismOfCoherentSheavesOnProjRep,
                          [ IsHomalgChainMorphism, IsImageSquare ] ] ] ],
                [ "OnObjects", _Functor_Cokernel_OnCoherentSheafOnProj ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_Cokernel_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
InstallFunctor( functor_Cokernel_ForCoherentSheafOnProj );

##
## ImageObject
##

InstallGlobalFunction( _Functor_ImageObject_OnCoherentSheafOnProj,  ### defines: ImageObject(Emb)
  function( phi )
    local emb, img, coker_epi, img_submodule;
    
    if HasImageObjectEmb( phi ) then
        return Source( ImageObjectEmb( phi ) );
    fi;
    
    emb := SheafMorphism( ImageObjectEmb( UnderlyingGradedMap( phi ) ), "create", Range( phi ) );
    
    ## set the attribute ImageObjectEmb (specific for ImageObject):
    ## (since ImageObjectEmb is listed below as a natural transformation
    ##  for the functor ImageObject, a method will be automatically installed
    ##  by InstallFunctor to fetch it by first invoking the main operation ImageObject)
    SetImageObjectEmb( phi, emb );
    
    if HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
        SetIsIsomorphism( emb, true );
    else
        SetIsMonomorphism( emb, true );
    fi;

    ## get the image module from its embedding
    img := Source( emb );
    
    #=====# end of the core procedure #=====#
    
    ## abelian category: [HS, Prop. II.9.6]
    if HasCokernelEpi( phi ) then
        coker_epi := CokernelEpi( phi );
        SetCokernelEpi( emb, coker_epi );
        if not HasKernelEmb( coker_epi ) then
            SetKernelEmb( coker_epi, emb );
        fi;
    fi;
    
    ## at last define the image submodule
    img_submodule := ImageSubobject( phi );
    
    SetUnderlyingSubobject( img, img_submodule );
    SetEmbeddingInSuperObject( img_submodule, emb );
    
    ## save the natural embedding in the image (thanks GAP):
    img!.NaturalGeneralizedEmbedding := emb;
    
#     if HasTruncatedModuleOfGlobalSections( phi ) then
#         SetTruncatedModuleOfGlobalSections( emb, UnderlyingGradedMap( emb ) );
#         SetTruncatedModuleOfGlobalSections( img_submodule, UnderlyingGradedModule( img_submodule ) );
#         SetTruncatedModuleOfGlobalSections( img, UnderlyingGradedModule( img ) );
#     fi;
    
    return img;
    
end );

##  <#GAPDoc Label="functor_ImageObject:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( functor_ImageObject_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "ImageObject" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "ImageObject" ],
                [ "natural_transformation", "ImageObjectEmb" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant" ],
                        [ IsMorphismOfCoherentSheavesOnProjRep ] ] ],
                [ "OnObjects", _Functor_ImageObject_OnCoherentSheafOnProj ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

functor_ImageObject_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctorOnObjects( functor_ImageObject_ForCoherentSheafOnProj );


##
## SheafHom
##

InstallGlobalFunction( _Functor_SheafHom_OnCoherentSheafOnProj,    ### defines: SheafHom (object part)
  function( F, G )
    local hom, emb, HP0N;
    
    CheckIfTheyLieInTheSameCategory( F, G );
    
    hom := GradedHom( UnderlyingGradedModule( F ), UnderlyingGradedModule( G ) );
    emb := NaturalGeneralizedEmbedding( hom );
    
    HP0N := Proj( Range( emb ) );
    
    emb := SheafMorphism( emb, "create", HP0N );
    hom := Source( emb );
    
    hom!.NaturalGeneralizedEmbedding := emb;
    
    # we can not set TruncatedModuleOfGlobalSections, because negative degrees would have to be truncated
    
    return hom;
    
end );

##
InstallGlobalFunction( _Functor_SheafHom_OnMorphismsOfCoherentSheafOnProj,     ### defines: SheafHom (morphism part)
  function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )

    if arg_before_pos = [ ] and Length( arg_behind_pos ) = 1 then
        
        return SheafMorphism( GradedHom( UnderlyingGradedMap( phi ), UnderlyingGradedModule( arg_behind_pos[1] ) ), F_source, F_target );
        
    elif Length( arg_before_pos ) = 1 and arg_behind_pos = [ ] then
        
        return SheafMorphism( GradedHom( UnderlyingGradedModule( arg_before_pos[1] ), UnderlyingGradedMap( phi ) ), F_source, F_target );
        
    else
        Error( "wrong input\n" );
    fi;
     
end );

##  <#GAPDoc Label="Functor_Hom:code">
##      <Listing Type="Code"><![CDATA[
InstallValue( Functor_SheafHom_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "SheafHom" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "SheafHom" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant", "right adjoint", "distinguished" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "2", [ [ "covariant", "left exact" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "OnObjects", _Functor_SheafHom_OnCoherentSheafOnProj ],
                [ "OnMorphisms", _Functor_SheafHom_OnMorphismsOfCoherentSheafOnProj ],
                [ "MorphismConstructor", HOMALG_SHEAVES_PROJ.category.MorphismConstructor ]
                )
        );
##  ]]></Listing>
##  <#/GAPDoc>

Functor_SheafHom_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_SheafHom_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_SheafHom_ForCoherentSheafOnProj );

InstallMethod( SheafHom, 
        "for a sheaf of modules and a sheaf of rings over proj",
        [ IsSheafOfModules, IsSheafOfRings ],
  function( F, O )
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) then
        return SheafHom( F, AsLeftObject( O ) );
    else
        return SheafHom( F, AsRightObject( O ) );
    fi;
    
end );

InstallMethod( SheafHom, 
        "for a sheaf of rings and a sheaf of modules over proj",
        [ IsSheafOfRings, IsSheafOfModules ],
  function( O, F )
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( F ) then
        return SheafHom( F, AsLeftObject( O ) );
    else
        return SheafHom( F, AsRightObject( O ) );
    fi;
    
end );

##
InstallMethod( NatTrIdToHomHom_R,
        "for sheaves of modules on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    local HHF, nat, epsilon;
    
    HHF := SheafHom( SheafHom( F ) );
    
    nat := NatTrIdToHomHom_R( UnderlyingGradedModule( F ) );
    
    epsilon := SheafMorphism( nat, F, HHF );
    
    SetPropertiesIfKernelIsTorsionObject( epsilon );
    
    return epsilon;
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg graded rings",
        [ IsSheafOfRings, IsString ],
        
  function( O, name )
    
    return InsertObjectInMultiFunctor( Functor_SheafHom_ForCoherentSheafOnProj, 2, AsLeftObject( O ), name );
    
end );

##
InstallMethod( LeftDualizingFunctor,
        "for homalg graded rings",
        [ IsSheafOfRings ],
        
  function( O )
    
    if not IsBound( O!.Functor_R_Hom ) then
        
        if not IsBound( HomalgRing( O )!.creation_number ) then
            Error( "the corresponding homalg ring does not have a creation number" );
        fi;
        
        O!.Functor_R_Hom := LeftDualizingFunctor( O, Concatenation( "Sheaf_O", String( HomalgRing( O )!.creation_number ), "_SheafHom" ) );
    fi;
    
    return O!.Functor_R_Hom;
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg graded rings",
        [ IsSheafOfRings, IsString ],
        
  function( O, name )
    
    return InsertObjectInMultiFunctor( Functor_SheafHom_ForCoherentSheafOnProj, 2, AsRightObject( O ), name );
    
end );

##
InstallMethod( RightDualizingFunctor,
        "for homalg graded rings",
        [ IsSheafOfRings ],
        
  function( O )
    local cn;
    
    if not IsBound( O!.Functor_Hom_R ) then
        
        if not IsBound( HomalgRing( O )!.creation_number ) then
            Error( "the corresponding homalg ring does not have a creation number" );
        fi;
        
        O!.Functor_Hom_R := RightDualizingFunctor( O, Concatenation( "Sheaf_SheafHom_O", String( HomalgRing( O )!.creation_number ) ) );
    fi;
    
    return O!.Functor_Hom_R;
    
end );

##
InstallMethod( Dualize,
        "for (sub)sheaves of modules on proj",
        [ IsCoherentSheafOrSubsheafOnProjRep ],
        
  SheafHom );

##
InstallMethod( Dualize,
        "for morphisms of sheaves of modules on proj",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  SheafHom );

RightDerivedCofunctor( Functor_SheafHom_ForCoherentSheafOnProj );

##
## SheafExt
##

##
RightSatelliteOfCofunctor( Functor_SheafHom_ForCoherentSheafOnProj, "SheafExt" );


##
## GlobalSection
##

InstallGlobalFunction( _Functor_GlobalSections_OnCoherentSheafOnProj,  ### defines: GlobalSection
  function( F )
    
    return HomogeneousPartOfDegreeZeroOverCoefficientsRing( TruncatedModuleOfGlobalSections( F ) );
    
end );

InstallGlobalFunction( _Functor_GlobalSections_ForMorphismsOfCoherentSheafOnProj,  ### defines: GlobalSection
  function( phi )
    
    return HomogeneousPartOfDegreeZeroOverCoefficientsRing( TruncatedModuleOfGlobalSections( phi ) );
    
end );

InstallValue( Functor_GlobalSections_ForCoherentSheafOnProj,
        CreateHomalgFunctor(
                [ "name", "GlobalSections" ],
                [ "category", HOMALG_SHEAVES_PROJ.category ],
                [ "operation", "GlobalSections" ],
                [ "number_of_arguments", 1 ],
                [ "1", [ [ "covariant", "left exact" ], HOMALG_SHEAVES_PROJ.FunctorOn ] ],
                [ "OnObjects", _Functor_GlobalSections_OnCoherentSheafOnProj ],
                [ "OnMorphisms", _Functor_GlobalSections_ForMorphismsOfCoherentSheafOnProj ]
                )
        );

Functor_GlobalSections_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

Functor_GlobalSections_ForCoherentSheafOnProj!.ContainerForWeakPointersOnComputedBasicMorphisms :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

InstallFunctor( Functor_GlobalSections_ForCoherentSheafOnProj );

##
## Hom
##

ComposeFunctors( Functor_GlobalSections_ForCoherentSheafOnProj, 1, Functor_SheafHom_ForCoherentSheafOnProj, "Hom", "Hom" );

##
## Ext
##

RightSatelliteOfCofunctor( Functor_Hom_for_coherent_sheaves_on_proj, "Ext" );
