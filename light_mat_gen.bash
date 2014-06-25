#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a radiance material of primitive "light", of name defined by input 1, and radiance by input 2.

# Input 1 : light material name
# Input 2 : light radiance

##############################
#           Script           #
##############################

# Input 1 : light material
# Input 2 : light radiance

echo "
void light $1
0
0
3 $2 $2 $2"
