#!/bin/bash

# Compile the CUDA program
echo "Compiling nbody_sp25.cu..."
nvcc -o nbody nbody_sp25.cu -lm

if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    
    # Test with different numbers of points
    for n in 100 1000 10000 100000
    do
        echo ""
        echo "Testing with $n points:"
        ./nbody $n
    done
else
    echo "Compilation failed!"
    exit 1
fi