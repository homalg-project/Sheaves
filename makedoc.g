##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/Sheaves.bib" );
WriteBibXMLextFile( "doc/SheavesBib.xml", bib );

list := [
         "../gap/LinearSystems.gd",
         "../gap/LinearSystems.gi",
         "../gap/Sheaves.gd",
         "../gap/Sheaves.gi",
         "../gap/SheafMap.gd",
         "../gap/SheafMap.gi",
         "../gap/Schemes.gd",
         "../gap/Schemes.gi",
         "../gap/MorphismsOfSchemes.gd",
         "../gap/MorphismsOfSchemes.gi",
         "../gap/Curves.gd",
         "../gap/Curves.gi",
         ];

MakeGAPDocDoc( "doc", "SheavesForHomalg", list, "SheavesForHomalg" );

GAPDocManualLab( "Sheaves" );

quit;
