#!/bin/bash

if [ "$1" -nt "$2" ];then
echo "$1 is newer"
else
echo "$1 is older"
fi
