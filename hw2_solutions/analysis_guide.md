# Analysis Guide for HW2 Problems 3 and 6

## Problem 3: Analysis of List Minimum Performance

When you run the experiments and plot the results, you should observe the following patterns:

### Expected Observations:
1. **Initial Speedup (1-8 threads)**: You'll likely see good speedup as you increase threads from 1 to around 8-16 threads.

2. **Diminishing Returns (8-64 threads)**: The speedup improvement will slow down significantly.

3. **Performance Degradation (>64 threads)**: Beyond a certain point, adding more threads actually increases execution time.

### Reasons for Observed Variation:

1. **Parallel Overhead**: Creating and managing threads has overhead. With too many threads, this overhead dominates the benefits of parallelization.

2. **Cache Effects**: 
   - With few threads, each thread's data fits in L1/L2 cache
   - With many threads, cache thrashing occurs as threads compete for cache space
   - False sharing: Multiple threads updating the global minimum can cause cache line bouncing

3. **Synchronization Overhead**:
   - Every thread must acquire the mutex to update the global minimum
   - With more threads, contention for the mutex increases
   - Threads spend more time waiting for the lock than doing useful work

4. **Hardware Limitations**:
   - The system has a limited number of physical CPU cores (likely 8-16)
   - Beyond this, threads must share cores through context switching
   - Context switching adds significant overhead

5. **Memory Bandwidth**:
   - All threads read from the array in memory
   - Memory bandwidth becomes a bottleneck with many threads

### Sample Answer for Problem 3:

"The execution time initially decreases as we increase threads from 1 to approximately 8-16, showing good speedup due to effective parallelization. However, beyond 16 threads, performance degrades due to several factors:

1. Synchronization overhead increases as more threads compete for the mutex protecting the global minimum
2. Cache efficiency decreases with more threads, leading to more cache misses and false sharing
3. The system's physical core count is exceeded, causing expensive context switching
4. Memory bandwidth becomes saturated with too many concurrent memory accesses

The optimal thread count appears to be around [8-16], matching the number of physical cores available."

## Problem 6: Analysis of Barrier Performance with Zero Sleep Time

When you set sleeptime to 0, the barrier experiments will show different behavior:

### Expected Observations:
1. **Linear or Super-linear Growth**: Execution time will grow linearly or even super-linearly with the number of threads.

2. **No Plateau**: Unlike the work-simulation case, there won't be a plateau in execution time.

### Characterization of Growth:

The growth pattern is typically **O(p) or O(p log p)** where p is the number of threads.

### Reasons for This Growth:

1. **Pure Synchronization Overhead**: 
   - Without any real work, the program only measures synchronization cost
   - Each thread immediately hits the barrier after creation

2. **Contention on Mutex**:
   - All threads try to acquire the mutex almost simultaneously
   - This creates a serialization bottleneck
   - More threads = more contention = longer wait times

3. **Condition Variable Overhead**:
   - Waking up p-1 threads with pthread_cond_broadcast has O(p) complexity
   - The OS must schedule and context switch between all waiting threads

4. **No Work to Amortize Costs**:
   - In real applications, synchronization overhead is amortized over useful work
   - Here, we're measuring pure overhead with no benefit

### Sample Answer for Problem 6:

"When sleeptime is set to 0, the execution time shows linear growth with the number of threads. This growth pattern can be characterized as O(p), where p is the number of threads.

The reason for this growth is that we're measuring pure synchronization overhead without any useful work to amortize the costs. Each additional thread adds:
1. Mutex contention as all threads race to increment the counter
2. Condition variable overhead for waking up waiting threads
3. Context switching overhead as the OS manages more threads

This demonstrates that barriers and synchronization primitives have inherent costs that scale with thread count, emphasizing the importance of having sufficient work between synchronization points in parallel programs."

## Tips for Creating Good Plots:

1. Use logarithmic scale (base 2) for the x-axis when plotting thread counts
2. Include grid lines for easier reading
3. Label axes clearly with units
4. For speedup plots, include the "ideal speedup" line (y=x) for comparison
5. Use different colors/markers for different data series
6. Save plots in high resolution (300 DPI) for the report

## Running on Grace:

1. Load the Intel compiler module: `module load intel`
2. Submit jobs using SLURM for dedicated mode execution
3. Request sufficient cores for your experiments (at least 16)
4. Use exclusive node access to avoid interference from other jobs
