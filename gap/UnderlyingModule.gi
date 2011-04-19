##
InstallMethod( BoundForResolution,
        "for homalg modules",
        [ IsCoherentSheafOnProjRep ],

  function( F )
    
    return BoundForResolution( UnderlyingGradedModule( F ) );
    
end );