#!/bin/bash

echo ${0##*/}
echo $#
test "$#" -lt 2 && echo "para less then 2"
echo "$@"
echo ${1}
echo ${2}
