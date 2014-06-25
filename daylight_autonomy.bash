#!/bin/bash

##############################
#        Description         #
##############################

# This script calculates the daylight autonomy of a building on a grid of points.
# The illuminance treshold is given by input 1.
# Input 2 gives the times series of a real scalar, multiplying the illuminance for each time step used in the calculation.
# The table of illuminance (calculated for a value of input 2 = 1) is given by input 3.
# The name of the output is given by input 4.

##############################
#           Inputs           #
##############################

illuminance_treshold=$2 # In lux
# Column of radiance values:
radiance_values_column=$3
# Table of illuminance coefficients:
illuminance_coefficients_table=$4
# Side of the grid surface
grid_side=$5
# Output file name
grid_resolution=$6 # Without .pts or any extension! The extension is written automatically.
# grid resolution
ambient_bounces=$7

##############################
#         Processing         #
##############################

> ./$1/ab"$ambient_bounces"_grid"$grid_resolution"_daylight_autonomy.pts

number_of_radiance_values=$(wc -l < "$radiance_values_column")

let "daylight_autonomy_counter=0"

while read col1 col2 col3
do
	while read col_rad
	do
		illuminance_temp=$(echo "$col3*$col_rad" |bc -l)
#		echo $col3 " times " $col_rad " equals " $illuminance_temp >> $output_file_name
		if (( $(echo "$illuminance_temp > $illuminance_treshold" | bc -l) ))
			then let "daylight_autonomy_counter=$daylight_autonomy_counter + 1"
#			echo $illuminance_temp " greater or equal to " $illuminance_treshold >> $output_file_name
#			echo "Counter now at " $daylight_autonomy_counter >> $output_file_name
#			else # echo "Counter now at " $daylight_autonomy_counter >> $output_file_name
#			echo $illuminance_temp " lower than " $illuminance_treshold >> $output_file_name
		fi
	done < $radiance_values_column
#	echo "Finally, counter at " $daylight_autonomy_counter " over " $number_of_radiance_values
	daylight_autonomy_temp=$(echo "scale=4; ($daylight_autonomy_counter/$number_of_radiance_values)*100" |bc -l)
#	echo "So DA = " $daylight_autonomy_temp
	echo $col1 $col2 $daylight_autonomy_temp >> ./$1/ab"$ambient_bounces"_grid"$grid_resolution"_daylight_autonomy.pts
	let "daylight_autonomy_counter=0"
done < $illuminance_coefficients_table

awk '{ if ((NR % '$grid_resolution') == 1 && NR != 1 ) printf("\n"); print; }' ./$1/ab"$ambient_bounces"_grid"$grid_resolution"_daylight_autonomy.pts > ./$1/temp_daylight_autonomy

#with
echo "set terminal pngcairo enhanced font \"arial,10\" fontscale 1.0 size 500, 350 
set output 'ab"$ambient_bounces"_grid"$grid_resolution"_daylight_autonomy_map.png'
unset key
set view map
set xtics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ytics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ztics border in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
set rtics axis in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
unset title
set size ratio -1
set xrange [ 0 : $grid_side ] noreverse nowriteback
set yrange [ 0 : $grid_side ] noreverse nowriteback
set cbrange [ 0 : 100 ]
set cblabel \"Daylight Autonomy $illuminance_treshold (%)\" 
set palette rgbformulae 33,13,10
plot \".\/$1\/temp_daylight_autonomy\" using 2:1:3 with image" > ./$1/temp_da_plotcommands.gp

gnuplot ./$1/temp_da_plotcommands.gp

mv ./ab"$ambient_bounces"_grid"$grid_resolution"_daylight_autonomy_map.png ./$1