#!/bin/bash

# Script for Problem 2: Running list_minimum experiments
# Run on Grace with: sbatch run_minimum_experiments.sh

#SBATCH --job-name=minimum_exp
#SBATCH --output=minimum_results.txt
#SBATCH --time=00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8G

module load intel

# Compile the program
icx -o list_minimum.exe list_minimum.c -lpthread -lc -lrt

# Set number of elements
n=200000000

# Run experiments for p = 2^k, k = 0 to 13
echo "Thread Count,Execution Time"
for k in {0..13}
do
    p=$((2**k))
    echo -n "$p,"
    ./list_minimum.exe $n $p | awk -F'=' '{print $NF}' | awk '{print $1}'
done
