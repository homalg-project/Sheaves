ReadPackage( "Sheaves", "examples/MainExample.g" );

filt := PurityFiltration( W );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

#Display( StringTime( homalgTime( S ) ) );
