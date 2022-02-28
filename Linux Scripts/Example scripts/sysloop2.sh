#!/bin/bash

commands=(
'date'
'uname -a'
'hostname -s' )

for i in ${commands[@]}
do
	echo "The results of the $i command are:"
	$i
done
