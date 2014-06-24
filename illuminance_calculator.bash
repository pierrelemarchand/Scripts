#!/bin/bash

##############################
#        Description         #
##############################

# This script calculates and plots the horizontal illuminance on a regular grid of points.
# The radiance scene comes from the octree envelope.oct located in the file given by input 1.
# The grid is an horizontal square of which one vertex is the origin, located in the quarter of plane (x>0,y>0).
# Its side is given by input 2 and its height by input 3.
# Its resolution is given by input 4.

# Input 1 : envelope name
# Input 2 : side of the grid surface
# Input 3 : height of the grid surface
# Input 4 : grid resolution

##############################
#           Script           #
##############################

ambient_bounces=0

echo "rvu -vtl -vp $(echo "$2/2" | bc -l) $(echo "$2/2" | bc -l) $2 -vd 0 0 -1 -vu 0 1 0 -vh $2 -vv $2" > $1/down_l.vf

# Writing and calling script calculating illuminance

echo \
"
# Calculating vertical illuminance of ground (array)
vwrays -x $4 -y $4 -vf $1/down_l.vf \
	| rcalc -e '\$1=\$1;\$2=\$2;\$3=$3;\$4=\$4;\$5=\$5;\$6=1' \
	| rtrace -I -ab $ambient_bounces -h -oov $1/envelope.oct \
	| rcalc -e '\$1=\$1;\$2=\$2;\$3=179*(.265*\$4+.670*\$5+.065*\$6)' \
	> $1/ab"$ambient_bounces"_grid"$4"illuminance.pts
" \
	> $1/temp_script.bash
chmod u+x $1/temp_script.bash

./$1/temp_script.bash

awk '{ if ((NR % '$4') == 1 && NR != 1) printf("\n"); print; }' $1/"ab"$ambient_bounces"_grid"$4"illuminance".pts > $1/temp_coefficients.pts

#with
echo "set terminal pngcairo enhanced font \"arial,10\" fontscale 1.0 size 550, 450 
set output 'illuminance_map.png'
unset key
set view map
set xtics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ytics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ztics border in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
set rtics axis in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
unset title
set size ratio -1
set xrange [ 0 : $2 ] noreverse nowriteback
set yrange [ 0 : $2 ] noreverse nowriteback
set cblabel \"Illuminance (lux)\" 
set palette rgbformulae 33,13,10
plot \"$1/temp_coefficients.pts\" using 2:1:3 with image" > $1/temp_plotcommands.gp

gnuplot $1/temp_plotcommands.gp

mv illuminance_map.png $1
