##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/Sheaves.bib" );
WriteBibXMLextFile( "doc/SheavesBib.xml", bib );

Read( "ListOfDocFiles.g" );

MakeGAPDocDoc( "doc", "SheavesForHomalg", list, "SheavesForHomalg" );

GAPDocManualLab( "Sheaves" );

quit;
