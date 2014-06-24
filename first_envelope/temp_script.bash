
# Calculating vertical illuminance of ground (array)
vwrays -x 10 -y 10 -vf first_envelope/down_l.vf 	| rcalc -e '$1=$1;$2=$2;$3=100;$4=$4;$5=$5;$6=1' 	| rtrace -I -ab 0 -h -oov first_envelope/envelope.oct 	| rcalc -e '$1=$1;$2=$2;$3=179*(.265*$4+.670*$5+.065*$6)' 	> first_envelope/ab0_grid10illuminance.pts

