#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a model of the inner surface of a TC Panel.
# The end of the optical fibers are discs of material given by input 1 and radius given by input 3,
# and the material surrounding them is given by input 2.
# Cospread of the optical fibers and side of the TC Panel are given by inputs 4 and 5.

# Input 1 : light material
# Input 2 : wall material
# Input 3 : OF radius
# Input 4 : OF cospread
# Input 5 : TCP side (square TCP) (should be more than 2*radius*cospread)

##############################
#           Script           #
##############################

./OF_gen.bash $1 $2 $3 $(echo "$5/(2*$4)" | bc -l) | xform -t $(echo "$5/(2*$4)" | bc -l) $(echo "$5/(2*$4)" | bc -l) 0 | xform -a $4 -t $(echo "$5/$4" | bc -l) 0 0 -a $4 -t 0 $(echo "$5/$4" | bc -l) 0