#!/bin/bash

watch -n ${1:-5} 'nvidia-smi |cowthink -n -f $(ls /usr/share/cowsay/cows/ | shuf -n 1)'
