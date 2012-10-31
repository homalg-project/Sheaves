#############################################################################
##
##  Curves.gd                   Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of procedures for curves.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "ProjectivePlaneCurve",
        [ IsHomalgModule, IsHomalgMatrix ] );

DeclareOperation( "RandomProjectivePlaneCurve",
        [ IsInt, IsList, IsList ] );

DeclareOperation( "RandomProjectivePlaneCurve",
        [ IsInt, IsList ] );

DeclareOperation( "RandomProjectivePlaneCurve",
        [ IsInt, IsHomalgModule ] );

