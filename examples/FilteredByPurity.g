ReadPackage( "Sheaves", "examples/Purity.g" );

SetAsOriginalPresentation( W );

FilteredByPurity( W );

Display( W );

Assert( 0, Collected( DegreesOfGenerators( W ) ) = [ [ 0, 5 ], [ 1, 1 ], [ 2, 2 ], [ 3, 1 ] ] );
