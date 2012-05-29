#############################################################################
##
##  Tools.gi                                                 Sheaves package
##
##  Copyright 2012,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
#############################################################################

##
CommonHomalgTableForLocalizedRingsTools.Diff :=
  function( D, N )
    
    if not IsOne( Denominator( N ) ) then
        Error( "the second matrix has a non-constant denominator" );
    elif not IsOne( Denominator( D ) ) then
        Error( "the first matrix has a non-constant denominator" );
    fi;
    
    return HomalgLocalMatrix(
                   Diff( Numerator( D ), Numerator( N ) ),
                   HomalgRing( D ) );
    
end;
