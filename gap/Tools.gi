#############################################################################
##
##  Tools.gi                    Sheaves package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of tool procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="Eliminate">
##  <ManSection>
##    <Oper Arg="rel, indets" Name="Eliminate"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Eliminate the independents <A>indets</A> from the list of ring elements <A>rel</A>, i.e. compute a generating set
##      of the ideal defined as the intersection of the ideal generated by the entries of the list <A>rel</A>
##      with the subring generated by all indeterminates except those in <A>indets</A>.
##      by the list of indeterminates <A>indets</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Eliminate,
        "for lists of ring elements",
        [ IsList, IsList ],
        
  function( rel, indets )
    local R, RP, elim;
    
    if rel = [ ] then
        Error( "first argument empty\n" );
    fi;
    
    R := HomalgRing( rel[1] );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.Eliminate) then
        elim := RP!.Eliminate( rel, indets, R );	## the external object
        elim := HomalgMatrix( elim, R );
        SetNrColumns( elim, 1 );
        return elim;
    fi;
    
    if IsHomalgExternalRingRep( R ) then
        Error( "could not find a procedure called Eliminate in the homalgTable of the external ring\n" );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TryNextMethod( );
    
end );
