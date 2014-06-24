#!/bin/bash

##############################
#        Description         #
##############################

# This script generates a simple envelope featuring TCPs, using other tool scripts, and runs calculations about it.

##############################
#           Inputs           #
##############################

# Materials parameters
lights_radiance=1
wall_color=.9
# (http://www.jaloxa.eu/resources/radiance/colour_picker/index.shtml can be helpful)
# Geometry parameters
box_side=300
work_plane_height=100
OFcospread=15 # Array of OFcospread * OFcospread
OFradius=5 # In %. The Optical Fibers must not overlap!
grid_resolution=10
# Name of the file
envelope_name="first_envelope"

##############################
#           Script           #
##############################

echo ""
echo "  Creating radiance files..."

mkdir -p $envelope_name

./light_mat_gen.bash lightmat $lights_radiance > ./$envelope_name/envelope.rad
./wall_mat_gen.bash wallmat $wall_color >> ./$envelope_name/envelope.rad
./wall_gen.bash wallmat $box_side >> ./$envelope_name/envelope.rad
./wall_gen.bash wallmat $box_side | xform -rx 90 | xform -t 0 $box_side 0 >> ./$envelope_name/envelope.rad
./TCP_gen.bash lightmat wallmat $OFradius $OFcospread $box_side | xform -ry 90 | xform -t 0 0 $box_side >> ./$envelope_name/envelope.rad
./TCP_gen.bash lightmat wallmat $OFradius $OFcospread $box_side | xform -rx -90 | xform -t 0 0 $box_side >> ./$envelope_name/envelope.rad
./wall_gen.bash wallmat $box_side | xform -ry -90 | xform -t $box_side 0 0 >> ./$envelope_name/envelope.rad
./TCP_gen.bash lightmat wallmat $OFradius $OFcospread $box_side | xform -rx 180 | xform -t 0 $box_side $box_side >> ./$envelope_name/envelope.rad

echo "  Creating schema of the envelope..."

objline ./$envelope_name/envelope.rad | psmeta > ./$envelope_name/envelope.eps

echo "  Creating octree..."

oconv ./$envelope_name/envelope.rad > $envelope_name/envelope.oct

# ./up_picture.bash $envelope_name $(echo "$box_side/2" | bc -l) $(echo "$box_side/2" | bc -l)

echo "  Calculating illuminance..."

./illuminance_calculator.bash $envelope_name $box_side $work_plane_height $grid_resolution

echo "  Done."
echo ""