#!/bin/bash

##############################
#        Description         #
##############################

# This script calculates the horizontal illuminance at a point.
# The radiance scene comes from the octree envelope.oct located in the file given by input 1.
# The coordinates of the point comes from inputs 2, 3, 4.

# Input 1 : envelope name
# Inputs 2, 3, 4 : x, y, z of the measurement point.

##############################
#           Script           #
##############################

echo "$2 $3 $4 0 0 1" \
	| rtrace -I -ab 0 -h -oov $1/envelope.oct \
	| rcalc -e '$1=179*(.265*$4+.670*$5+.065*$6)' # >> $1/illuminance_point