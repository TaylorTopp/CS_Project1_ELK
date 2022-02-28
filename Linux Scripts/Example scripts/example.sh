#!/bin/bash

OUT=$HOME/research

IP=$(ip addr | grep inet | tail -2 | head -1)
echo "$IP"

PERM=$(find /home -type f -perm 777)
echo "$PERM"


if [  $(id -u) = 0 ]
  then
	echo "Do not run this script with sudo"
	exit
fi

if [ -d $OUT ]
  then
        echo "Research exists"
  else
        mkdir $OUT
fi

if [ -f $OUT/sys_info.txt ]
  then 
        rm  $OUT/sys_info.txt
	echo "sys_info.txt deleted"
  else 
        echo "sys_info.txt does not exist"
  fi

