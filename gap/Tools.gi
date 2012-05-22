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
  function( M, N )
    local R, diff;
    
    if not IsOne( Denominator( N ) ) then
        Error( "the second matrix has a non-constant denominator" );
    elif not IsOne( Denominator( M ) ) then
        Error( "the first matrix has a non-constant denominator" );
    fi;
    
    R := HomalgRing( M );
    
    diff := Diff( Numerator( M ), Numerator( N ) );
    
    return diff;
    
end;
