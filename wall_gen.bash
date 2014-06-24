#!/bin/bash

# Input 1 : wall material
# Input 2 : wall side (square wall)

echo "
$1 polygon square_wall
0
0
12
0 0 0
$2 0 0
$2 $2 0
0 $2 0"
