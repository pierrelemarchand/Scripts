#!/bin/bash

for i in $(seq 1 5)
do ./parametric_envelope_generator.bash $(echo "10^$i" | bc -l)
#do echo $(echo "10^$i" | bc -l)
done