#!/bin/bash

paths=('/etc/passwd' '/etc/shadow')

for perm in ${paths[@]}
do
	ls -l $perm
done
