#!/bin/bash

serials=("ABC" "DEF" "GHI" "JKL")

for ((i = 0 ; i < ${#serials[@]} ; i++))
do
    echo "Serial at index $i: ${serials[i]}"
done
