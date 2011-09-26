Read( "MainExample.g" );

LoadPackage( "AbelianSystems" );

filt := PurityFiltrationViaAuslanderDuals( W );

#II_E := SpectralSequence( filt );
#

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( S ) ) );
