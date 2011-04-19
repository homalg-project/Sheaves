##
InstallMethod( BoundForResolution,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],

  function( F )
    
    return BoundForResolution( UnderlyingGradedModule( F ) );
    
end );

##
InstallMethod( TheIdentityMorphism,
        "for coherent sheaves on proj",
        [ IsCoherentSheafOnProjRep ],
        
  function( F )
    
    return SheafMorphism( TheIdentityMorphism( UnderlyingGradedModule( F ) ), F, F );
    
end );