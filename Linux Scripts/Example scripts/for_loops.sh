#!/bin/bash

states=('NSW' 'QLD' 'TAS' 'VIC' 'SA')

for state in ${states[@]}
do
	if [ $state == 'NSW' ]
	then
	  echo "$state IS DA BEST"
	elif [ $state == 'QLD' ]
	then
	  echo "$state would be dope to live in tho"
	else
	  echo "$state is a bad state"
fi
done

for i in {0..9}
do
	if [ $i = 3 ] || [ $i = 5 ] || [ $i = 9 ]
	then
	 echo $i
	fi

done
 for file in $(ls)
do
	ls -lah $file
done

for perm in $(find /home -type f -perm 777 2> /dev/null)
do
	echo "$perm"
done
