## [Har, Exercise V.2.17(a)]
ReadPackage( "Sheaves", "examples/d-uple_Embedding_of_P1.g" );

pb := Pullback( phi, conormal );

ByASmallerPresentation( pb );

Assert( 0, CastelnuovoMumfordRegularity( pb ) = 8 );

betti := BettiTable( TateResolution( pb, 1, 10 ) );

Assert( 0, MatrixOfDiagram( betti ) =
        [ [ 8, 6, 4, 2, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 2, 4, 6, 8, 10, 12 ] ] );

Assert( 0, CastelnuovoMumfordRegularityOfSheafification( pb ) = 5 );

pb := StandardModule( pb );

Assert( 0, IsFree( pb ) );
Assert( 0, DegreesOfGenerators( pb ) = [ 5, 5 ] );
