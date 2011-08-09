#############################################################################
##
##  Subsheaves.gi                                           Sheaves package
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

# two new types:
BindGlobal( "TheTypeHomalgLeftCoherentSubsheafOnProj",
        NewType( TheFamilyOfHomalgModules,
                IsCoherentSubsheafOnProjRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightCoherentSubsheafOnProj",
        NewType( TheFamilyOfHomalgModules,
                IsCoherentSubsheafOnProjRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatchPropertiesAndAttributesOfSubobjectAndUnderlyingObject,
        "for a coherent coheresubsheaf and its underlying coherent sheaf",
        [ IsCoherentSubsheafOnProjRep, IsCoherentSheafOnProjRep ],
        
  function( I, M )
    
    ## we don't check if M is the underlying object of I
    ## to avoid infinite loops as EmbeddingInSuperObject
    ## will be invoked
    if ConstructedAsAnIdeal( I ) then
        
        MatchPropertiesAndAttributes( I, M,
                LISHV.intrinsic_properties_shared_with_subobjects_and_ideals,
                LISHV.intrinsic_attributes_shared_with_subobjects_and_ideals );
        
    else
        
        MatchPropertiesAndAttributes( I, M,
                LISHV.intrinsic_properties_shared_with_subobjects_which_are_not_ideals,
                LISHV.intrinsic_attributes_shared_with_subobjects_which_are_not_ideals );
        
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( ImageSubobject,
        "subsheaf constructor",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local S, O, img, T, N;
    
    S := HomalgRing( UnderlyingGradedMap( phi ) );
    
    O := StructureSheafOfProj( S );
    
    img := ImageSubobject( UnderlyingGradedMap( phi ) );
    
    T := Range( phi );
    
    N := rec(
             map_having_subobject_as_its_image := phi,
             GradedModuleModelingTheSheaf := img
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftCoherentSubsheafOnProj,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                LeftActingDomain, O );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightCoherentSubsheafOnProj,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                RightActingDomain, O );
    fi;
    
    return N;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

