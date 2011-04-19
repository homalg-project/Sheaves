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
        "for sheaves",
        [ IsMorphismOfCoherentSheavesOnProjRep ],
        
  function( phi )
    local psi;
    
    psi := phi!.GradedModuleMapModelingTheSheaf;
    
    return ModuleOfGlobalSections( psi );
    
end );
