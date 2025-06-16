#!/bin/bash

# Script for Problem 5: Running barrier experiments
# Run on Grace with: sbatch run_barrier_experiments.sh

#SBATCH --job-name=barrier_exp
#SBATCH --output=barrier_results.txt
#SBATCH --time=00:30:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8G

module load intel

# Compile the program
icx -o barrier.exe barrier.c -lpthread -lrt

# Run experiments for p = 2^k, k = 1 to 14
echo "Thread Count,Execution Time"
for k in {1..14}
do
    p=$((2**k))
    echo -n "$p,"
    ./barrier.exe $p | awk -F'=' '{print $NF}' | awk '{print $1}'
done
