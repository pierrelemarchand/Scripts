set terminal pngcairo enhanced font "arial,10" fontscale 1.0 size 550, 450 
set output 'illuminance_map.png'
unset key
set view map
set xtics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ytics border in scale 0,0 mirror norotate  offset character 0, 0, 0 autojustify
set ztics border in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
set rtics axis in scale 0,0 nomirror norotate  offset character 0, 0, 0 autojustify
unset title
set size ratio -1
set xrange [ 0 : 300 ] noreverse nowriteback
set yrange [ 0 : 300 ] noreverse nowriteback
set cblabel "Illuminance (lux)" 
set palette rgbformulae 33,13,10
plot "first_envelope/temp_coefficients.pts" using 2:1:3 with image
