# N-Body CUDA Implementation Write-up

## Changes Made to the Code

### 1. GPU Kernel Implementation (`minimum_distance`)
- **Shared Memory Usage**: Implemented shared memory arrays to store coordinates and minimum distances for each block, reducing global memory access
- **Tiling Strategy**: Process points in tiles to improve memory access patterns and enable larger problem sizes
- **Parallel Computation**: Each thread computes minimum distance from its assigned point to all other points
- **Efficient Distance Calculation**: Avoid self-comparison and use fast square root function

### 2. Reduction Kernel (`reduce_minimum`)
- **Two-Phase Approach**: First kernel computes block-wise minimums, second kernel reduces to global minimum
- **Parallel Reduction**: Implemented efficient tree-based reduction within blocks
- **Shared Memory**: Used for fast intra-block communication during reduction

### 3. Kernel Launch Configuration
- **Dynamic Block Size**: Automatically adjusts threads per block based on problem size and device capabilities
- **Grid Configuration**: Calculates optimal grid dimensions for given input size
- **Shared Memory Allocation**: Dynamically allocates shared memory based on block size

### 4. Key Optimizations
- **Coalesced Memory Access**: Threads access consecutive memory locations for better bandwidth utilization
- **Warp Efficiency**: Reduction algorithm designed to minimize warp divergence
- **Memory Reuse**: Shared memory tiles reused across multiple distance calculations
- **Early Exit**: Skip unnecessary comparisons when distance already exceeds current minimum

## Performance Improvements

The GPU implementation achieves significant speedup over the CPU version:
- For small problem sizes (n < 256), CPU may be faster due to kernel launch overhead
- GPU becomes faster around n = 256-512
- Maximum speedup increases with problem size due to O(n²) complexity
- Data transfer overhead is minimal compared to computation time for large n

## Algorithm Complexity

- **CPU Algorithm**: O(n²) with nested loops
- **GPU Algorithm**: O(n²/p) where p is the number of parallel threads
- **Memory Usage**: O(n) for input/output arrays plus O(blocks) for intermediate results