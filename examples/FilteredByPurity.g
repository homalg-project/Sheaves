ReadPackage( "Sheaves", "examples/Purity.g" );

SetAsOriginalPresentation( W );

FilteredByPurity( W );

Display( W );

Assert( 0, DegreesOfGenerators( W ) = [ 0, 0, 0, 0, 0, 1, 2, 2, 3 ] );
