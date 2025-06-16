#!/bin/bash

# Test script to verify all programs compile and run correctly
# Run this before submitting to ensure everything works

echo "=== Testing HW2 Solutions ==="
echo

# Check if we're on Grace or similar system
if command -v icx &> /dev/null; then
    CC="icx"
elif command -v icc &> /dev/null; then
    CC="icc"
else
    echo "Intel compiler not found. Using gcc as fallback."
    CC="gcc"
fi

echo "Using compiler: $CC"
echo

# Compile all programs
echo "=== Compiling Programs ==="
$CC -o list_minimum.exe list_minimum.c -lpthread -lc -lrt
if [ $? -eq 0 ]; then
    echo "✓ list_minimum.c compiled successfully"
else
    echo "✗ Error compiling list_minimum.c"
fi

$CC -o barrier.exe barrier.c -lpthread -lrt
if [ $? -eq 0 ]; then
    echo "✓ barrier.c compiled successfully"
else
    echo "✗ Error compiling barrier.c"
fi

$CC -o list_statistics.exe list_statistics.c -lpthread -lc -lrt -lm
if [ $? -eq 0 ]; then
    echo "✓ list_statistics.c compiled successfully"
else
    echo "✗ Error compiling list_statistics.c"
fi

echo
echo "=== Running Test Cases ==="

# Test list_minimum
echo
echo "Testing list_minimum with 10000 elements and 4 threads:"
./list_minimum.exe 10000 4

# Test barrier
echo
echo "Testing barrier with 4 threads:"
./barrier.exe 4

# Test list_statistics
echo
echo "Testing list_statistics with 10000 elements and 4 threads:"
./list_statistics.exe 10000 4

echo
echo "=== Tests Complete ==="
echo
echo "If all tests passed, you're ready to:"
echo "1. Run the full experiments using the SLURM scripts"
echo "2. Create plots using plot_results.py"
echo "3. Write your analysis for problems 3 and 6"
echo "4. Submit the required files"
