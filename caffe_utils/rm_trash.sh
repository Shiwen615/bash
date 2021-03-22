#!/bin/bash

dir=('JDetNet' 'mobiledetnet-0.5' 'shiwen_SSDlite' 'shiwen_shuffleV2')

for d in ${dir[@]};do
	for dd in $(ls $d);do
		if ! ls $d/$dd/initial/*.caffemodel &> /dev/null;then
			sudo rm -r $d/$dd;
		fi;
	done
done
