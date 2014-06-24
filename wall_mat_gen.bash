#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a radiance material of primitive "plastic", used to model walls, of name defined by input 1, and color by input 2.

# Input 1 : wall material
# Input 2 : wall color (black to white only to simplify)

##############################
#           Script           #
##############################

echo "
void plastic $1
0
0
5 $2 $2 $2 .02 .08"
