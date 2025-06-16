# Project Plan: CSCE 435 HW1 - Parallel Programming

This project involves performing experiments and analyzing the performance of parallel programs for computing an estimate of PI, using both shared-memory (Pthreads) and distributed-memory (MPI) paradigms on the Grace HPC cluster.

## Part 1: Shared-Memory Programming with Threads (compute_pi.c)

1.  **Experiments for n=10^8:**
    *   Run with `p = 2^k` threads, for `k = 0, 1, ..., 13`.
    *   Plot: Execution time vs. `p`.
    *   Plot: Speedup vs. `p`.
    *   Plot: Efficiency vs. `p`.
    *   Identify `p` that minimizes parallel runtime.
2.  **Experiments for n=10^10:**
    *   Run with `p = 2^k` threads, for `k = 0, 1, ..., 13`.
    *   Identify `p` that minimizes parallel runtime.
    *   Analyze runtime behavior for large `p`.
3.  **Analysis:**
    *   Compare optimal `p` for different `n` values.
4.  **Error Analysis:**
    *   Run with `p = 48` for `n = 10^k`, `k = 3, ..., 9`.
    *   Plot: Error vs. `n`.

## Part 2: Distributed-Memory Programming with MPI (compute_pi_mpi.c)

1.  **Experiments for n=10^8:**
    *   Run with `p = 2^k` processes, for `k = 0, 1, ..., 6`.
    *   Use `ntasks-per-node=4`.
    *   Plot: Execution time vs. `p`.
    *   Plot: Speedup vs. `p`.
    *   Plot: Efficiency vs. `p`.
    *   Identify `p` that minimizes parallel runtime.
2.  **Optimization of ntasks-per-node:**
    *   Run with `n=10^10` and `p=64`.
    *   Vary `ntasks-per-node` to find the value that minimizes total time.
    *   Plot: Time vs. `ntasks-per-node`.
3.  **Speedup and Error Analysis (p=64, ntasks-per-node=4):**
    *   Run for `n = 10^2, 10^4, 10^6, 10^8`.
    *   Plot: Speedup vs. `n` (w.r.t. `p=1`).
    *   Plot: Relative error vs. `n`.

## Submission

A single PDF or MSWord document with answers and plots.
