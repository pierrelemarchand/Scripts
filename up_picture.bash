#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a picture looking up.
# The radiance scene comes from the octree envelope.oct located in the file given by input 1.
# The viewing point is at z=0, and x and y coordinates given by inputs 2 and 3.

# Input 1 : envelope name
# Input 2 : x coordinate of viewing point
# Input 3 : y coordinate of viewing point

##############################
#           Script           #
##############################

echo "rvu -vth -vp $2 $3 0 -vd 0 0 1 -vu 0 -1 0 -vh 180 -vv 180" > $1/up_v.vf
rpict -vf $1/up_v.vf -ab 0 $1/envelope.oct > $1/up_v.hdr