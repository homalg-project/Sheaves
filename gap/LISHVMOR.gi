#############################################################################
##
##  LISHVMOR.gi                               LISHVMOR subpackage of Sheaves
##
##         LISHV = Logical Implications for homalg SHeaVes
##
##  Copyright 2011,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################



####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( TruncatedModuleOfGlobalSections,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local psi;
    
    psi := phi!.GradedModuleMapModelingTheSheaf;
    
    return ModuleOfGlobalSections( psi );
    
end );

##
InstallMethod( IsAutomorphism,
        "for coherent sheaves on proj morphism",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    
    return IsAutomorphism( UnderlyingGradedMap( phi ) ) and IsEndomorphismOfSheavesOfModules( phi );
    
end );