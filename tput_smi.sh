#!/bin/bash
while getopts t: flag # 冒號(:)代表有參數值
case $flag in
	t) cycle_time=${OPTARG}
esac

cycle_time=${cycle_time:-3}

clear && tput sc && while :;do tput rc && nvidia-smi|lolcat; sleep $cycle_time; done
