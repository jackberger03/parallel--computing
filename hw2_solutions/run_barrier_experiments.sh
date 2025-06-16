#!/bin/bash

# Script for Problem 5: Running barrier experiments
# Fixed version to extract correct time values
module load intel
# Compile the program
icx -o barrier.exe barrier.c -lpthread -lrt

# Run experiments for p = 2^k, k = 1 to 14
echo "Thread Count,Execution Time"
for k in {1..14}
do
    p=$((2**k))
    time=$(./barrier.exe $p | awk '/barrier time/{print $8}')
    echo "$p,$time"
done