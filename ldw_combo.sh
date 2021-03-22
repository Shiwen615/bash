#!/bin/bash

local_arc_path='/mnt/c/Users/ray.hsu/Desktop/arc'
server='user@192.168.107.239'
remote_arc_path='adas/ldw_victor'
remote_bin_path='adas/ldw_victor/bin/ldw'
usb='f:'
usb_mnt='/mnt/f'

rsync -avzh $local_arc_path/* $server:$remote_arc_path/ &&

# ssh user@192.168.107.239 [[ -f adas/ldw_victor/bin/ldw ]] && rm adas/ldw_victor/bin/ldw
ssh $server [[ -f $remote_bin_path ]] && 
ssh $server rm $remote_bin_path

ssh $server ./adas/victorHuang_compile.sh &&

mount -t drvfs $usb $usb_mnt &&
scp -i ~/.ssh/id_rsa $server:$remote_bin_path $usb_mnt &&
umount -t drvfs $usb
