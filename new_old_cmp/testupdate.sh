#!/bin/bash

# src_dir='/home/user'
# dst_dir='/run/media/mmcblk1p2/home/user'
src_dir='./SD/user'
dst_dir='./emmc/user'

# src=$(ls $src_dir/ARC*)
# dst=$(ls $dst_dir/ARC*)

# src_ver=$(ls $src_dir/ARC* | rev |cut -d / -f 1 |rev)
src_ver=$(ls $src_dir/ARC*|grep -o '[^/]*$')
echo src:$src_ver
# dst_ver=$(ls $dst_dir/ARC* | rev |cut -d / -f 1 |rev)
dst_ver=$(ls $dst_dir/ARC*|grep -o '[^/]*$')
echo dst:$dst_ver

for i in {2..4};do
	src_sub_ver=$(echo $src_ver | cut -d _ -f $i)
	dst_sub_ver=$(echo $dst_ver | cut -d _ -f $i)

	if (( $src_sub_ver > $dst_sub_ver ));then
		echo 'start update'
		
		# touch /tmp/arc_update_enable
		tar -C $dst_dir -zxvf $src_dir/pack.tar.gz # dst_dir will be changed to /
		mv $dst_dir/$dst_ver $dst_dir/$src_ver
		# rm /tmp/arc_update_enable
		echo 'finish update'
		break
	elif (( $src_sub_ver < $dst_sub_ver ));then
		echo "won't update"
		break
	fi
done
