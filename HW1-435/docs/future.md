# Future Work

## Part 2: Distributed-Memory Programming with MPI

1.  **Data Parsing for MPI Output:**
    *   Adapt `main.py` or create a new Python script to parse the output from `compute_pi_mpi.c` runs. The output format might differ from `compute_pi.c`.
    *   Ensure the parser correctly extracts `n`, `p` (processes), `time`, and `relative error` for all experiments outlined in Part 2 (Questions 5, 6, 7).
    *   This will likely involve processing files from the `results_part2` directory (if `calculate.sh` was used to direct output there) or a consolidated MPI output file.

2.  **Calculations for MPI Experiments:**
    *   **Question 5 (n=10^8, p=2^k, ntasks-per-node=4):**
        *   Execution time vs. `p`.
        *   Speedup vs. `p`. This will require baseline runs with `p=1` for MPI with `n=10^8`.
        *   Efficiency (`speedup/p`) vs. `p`.
        *   Determine optimal `p` that minimizes runtime.
    *   **Question 6 (n=10^10, p=64, varying ntasks-per-node):**
        *   Execution time vs. `ntasks-per-node`.
        *   Identify `ntasks-per-node` that minimizes runtime.
    *   **Question 7 (p=64, ntasks-per-node=4, varying n):**
        *   Speedup vs. `n`. This requires `p=1` baseline runs for MPI for `n = 10^2, 10^4, 10^6, 10^8`.
        *   Relative error vs. `n`.

3.  **Plot Generation for MPI Experiments:**
    *   Generate plots corresponding to all analyses in Question 5, 6, and 7.
    *   Ensure plots have clear labels, titles, and use logarithmic scales for x-axes where specified.

4.  **Formulate Answers for MPI Questions:**
    *   Provide clear, data-supported answers for all sub-questions in Part 2 (5.1-5.4, 6, 7.1-7.2).

## Final Report

1.  **Consolidate All Results:** Gather all textual answers, plots, and summary tables from Part 1 and Part 2.
2.  **Structure Document:** Organize the findings into a single PDF or MSWord document as per submission guidelines.
3.  **Review and Finalize:** Ensure all aspects of the homework assignment have been addressed accurately and clearly.
