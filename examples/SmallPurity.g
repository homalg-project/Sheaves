Read( "SmallMainExample.g" );

filt := PurityFiltration( W );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( UnderlyingNonGradedRing( S ) ) ) );
