# HW2 Solutions Summary

## Completed Code Files

### Problem 1: list_minimum.c
**What was added:** The mutex-protected code to update the global minimum value.
```c
pthread_mutex_lock(&lock_minimum);

// Update global minimum if local minimum is smaller
if (count == 0) {
    // First thread to reach here initializes minimum
    minimum = my_minimum;
} else if (my_minimum < minimum) {
    // Update global minimum if we found a smaller value
    minimum = my_minimum;
}

// Increment count of threads that have updated minimum
count++;

pthread_mutex_unlock(&lock_minimum);
```

### Problem 4: barrier.c
**What was added:** The complete barrier implementation using condition variables.
```c
pthread_mutex_lock(&lock_barrier);

// Increment count to track how many threads have reached the barrier
count++;

// If this is the last thread to reach the barrier
if (count == num_threads) {
    // Reset count for potential reuse of barrier
    count = 0;
    
    // Wake up all waiting threads
    pthread_cond_broadcast(&cond_barrier);
} else {
    // Wait until all threads have reached the barrier
    while (count != 0) {
        pthread_cond_wait(&cond_barrier, &lock_barrier);
    }
}

pthread_mutex_unlock(&lock_barrier);
```

### Problem 7: list_statistics.c
**What was created:** A complete program that computes mean and standard deviation using threads, following the same style as list_minimum.c.

## Compilation Commands

```bash
# Load Intel compiler on Grace
module load intel

# Problem 1
icx -o list_minimum.exe list_minimum.c -lpthread -lc -lrt

# Problem 4
icx -o barrier.exe barrier.c -lpthread -lrt

# Problem 7
icx -o list_statistics.exe list_statistics.c -lpthread -lc -lrt -lm
```

## Running Experiments

### Problem 2 & 3: List Minimum Performance
```bash
# Run for n = 200,000,000 with p = 2^k for k = 0 to 13
sbatch run_minimum_experiments.sh
```

### Problem 5 & 6: Barrier Performance
```bash
# First run with default sleep time (2 seconds)
sbatch run_barrier_experiments.sh

# For Problem 6: Edit csce435.h to set sleeptime to 0,0
# Then run again to see pure synchronization overhead
```

## Important Notes for Problem 6
To complete Problem 6, you need to:
1. Edit `csce435.h`
2. Change `sleeptime.tv_sec = 0;` and `sleeptime.tv_nsec = 0;`
3. Recompile barrier.c
4. Run the experiments again

## Submission Checklist
- [ ] Problem 1: list_minimum.c (completed)
- [ ] Problem 2: Performance plots for list_minimum
- [ ] Problem 3: Analysis of performance variation
- [ ] Problem 4: barrier.c (completed)
- [ ] Problem 5: Performance plots for barrier
- [ ] Problem 6: Performance plots with zero sleep time and analysis
- [ ] Problem 7: list_statistics.c (completed)

## Files to Submit
1. **Code zip file containing:**
   - list_minimum.c
   - barrier.c
   - list_statistics.c

2. **PDF/Word document containing:**
   - Problem 2: Execution time and speedup plots
   - Problem 3: Analysis of performance variation
   - Problem 5: Barrier execution time plot
   - Problem 6: Zero-sleep barrier plot and analysis
