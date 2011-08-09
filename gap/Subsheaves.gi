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

