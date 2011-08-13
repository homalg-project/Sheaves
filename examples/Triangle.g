Read( "ReducedBasisOfModule.g" );

triangle := RSheafHom( C, T );
lecs := LongSequence( triangle );
IsExactSequence( lecs );
ByASmallerPresentation( lecs );
homalgResetFilters( lecs );
Assert( 0, IsExactSequence( lecs ) );

Triangle := LTensorProduct( C, T );
lehs := LongSequence( Triangle );
IsExactSequence( lehs );
ByASmallerPresentation( lehs );
homalgResetFilters( lehs );
Assert( 0, IsExactSequence( lehs ) );

Display( TimeToString( homalgTime( S ) ) );
