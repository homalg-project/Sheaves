Read( "RationalQuartic.g" );

## [Har, Exercise V.2.17(b)]
pb := Pullback( phi, conormal );

ByASmallerPresentation( pb );

Assert( 0, CastelnuovoMumfordRegularity( pb ) = 15 );

betti := BettiTable( TateResolution( pb, 1, 10 ) );

Assert( 0, MatrixOfDiagram( betti ) =
        [ [ 12, 10, 8, 6, 4, 2, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 2, 4, 6, 8 ] ] );

Assert( 0, CastelnuovoMumfordRegularityOfSheafification( pb ) = 7 );

pb := StandardModule( pb );

Assert( 0, IsFree( pb ) );
Assert( 0, DegreesOfGenerators( pb ) = [ 7, 7 ] );
