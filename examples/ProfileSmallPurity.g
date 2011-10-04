Read( "ProfileSmallMainExample.g" );

filt := PurityFiltration( W );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Display( StringTime( homalgTime( UnderlyingNonGradedRing( S ) ) ) );
