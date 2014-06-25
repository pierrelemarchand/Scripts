#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a disc of material given by input 1 and radius given by input 3,
# embedded in a square of material given by input 2 and half side given by input 4.

# Input 1 : light material
# Input 2 : wall material
# Input 3 : OF radius
# Input 4 : Square half side ( must be greqter than OF radius )

##############################
#         Parameters         #
##############################

precision=16 # Number of vectors describing the disc

##############################
#           Script           #
##############################

echo "
$1 polygon OFend
0
0
$(($precision*3))"

for i in $(seq 0 $(($precision-1)))
do echo " " $(echo "$3*c(8*a(1)*$i/$precision)" | bc -l) " " $(echo "$3*s(8*a(1)*$i/$precision)" | bc -l) " " 0
done

echo "
$2 polygon OFsurround
0
0
$((($precision+7)*3))"
echo " " $4 " " 0 " " 0
echo " " $4 " " $4 " " 0
echo " " -$4 " " $4 " " 0
echo " " -$4 " " -$4 " " 0
echo " " $4 " " -$4 " " 0
echo " " $4 " " 0 " " 0

for i in $(seq 0 $precision)
do echo " " $(echo "$3*c(8*a(1)*$i/$precision)" | bc -l) " " $(echo "-$3*s(8*a(1)*$i/$precision)" | bc -l) " " 0
done