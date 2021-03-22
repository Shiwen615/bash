#!/bin/bash

# Program:
#       This program check (boot,fs,app) version number, and update from SD card.
# History:
# 2020/09/22    Shiwen  First release

#src_ver_dir='./SD/user'
#dst_ver_dir='./emmc/user'

#version number file dir
src_ver_dir='/run/media/mmcblk0p1' 
dst_ver_dir='/run/media/mmcblk1p2/home/version'

SD_boot_dir='/run/media/mmcblk0p1'

#version number file name
vernum_file=('ubootver' 'rootfsver' 'appver')

update_func()
{
	case $1 in 
		ubootver)
			tar_pack='uboot-image.tar.gz'
			untar_path='/run/media/mmcblk1p1'
		;;
		rootfsver)
			tar_pack='rootfs-image.tar.gz'
			untar_path='/run/media/mmcblk1p2'
		;;
		appver)
			tar_pack='appsout-image.tar.gz'
			untar_path='/run/media/mmcblk1p2'
		;;
		*)
			echo 'wrong version file'
	esac

	tar -C $untar_path -zxvf $SD_boot_dir/$tar_pack &&
	cp $src_ver_dir/$1 $dst_ver_dir 
	
	if [[ -e /run/media/mmcblk1p2/etc/init.d/update.sh ]];then
		rm /run/media/mmcblk1p2/etc/init.d/update.sh
		rm /run/media/mmcblk1p2/etc/S80update.sh
	fi
	return 0
}


if [[ ! -d $dst_ver_dir ]];then
	mkdir $dst_ver_dir
fi

for file in ${vernum_file[@]};do
	if [[ ! -e $dst_ver_dir/$file ]] || [[ $(cat $dst_ver_dir/$file) -lt $(cat $src_ver_dir/$file) ]];then
		echo "${file%ver} start to update"
		touch /tmp/arc_update_enable #show updating image

		if update_func $file; then
			echo "${file%ver} update success"
		else
			echo "${file%ver} update failure"
		fi
		
		
		touch /tmp/arc_update_done #show update finish image
	else
		echo "${file%ver} already in newest version"
	fi
done

sync
