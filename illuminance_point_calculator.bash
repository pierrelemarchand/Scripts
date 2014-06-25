#!/bin/bash

##############################
#        Description         #
##############################

# This script calculates the horizontal at a point.
# The radiance scene comes from the octree envelope.oct located in the file given by input 1.

# Input 1 : envelope name

##############################
#           Script           #
##############################

echo "150 150 100 0 0 1" \
	| rtrace -I -ab 0 -h -oov $1/envelope.oct \
	| rcalc -e '$1=179*(.265*$4+.670*$5+.065*$6)' >> $1/illuminance_point