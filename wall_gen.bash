#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a square wall, of material given by input 1, and side size by input 2.

# Input 1 : wall material
# Input 2 : wall side (square wall)

##############################
#           Script           #
##############################

echo "
$1 polygon square_wall
0
0
12
0 0 0
$2 0 0
$2 $2 0
0 $2 0"
