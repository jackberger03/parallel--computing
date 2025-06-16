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
    # Run barrier and extract the time value correctly
    result=$(./barrier.exe $p)
    # Extract the barrier time (not the timer resolution)
    time=$(echo "$result" | grep "barrier time" | awk -F'=' '{print $2}' | awk '{print $1}')
    echo "$p,$time"
done