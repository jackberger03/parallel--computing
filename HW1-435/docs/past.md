# Past Accomplishments

*   **Initial Setup & Scripting (Assisted by AI):**
    *   Created `calculate.sh`: A comprehensive bash script to generate all necessary SLURM job files for Part 1 (Pthreads) and Part 2 (MPI) experiments.
    *   The `calculate.sh` script defines job parameters, creates output directories (`job_scripts`, `results_part1`, `results_part2`), and generates a `run_all_jobs.sh` master submission script.
*   **User Execution & Data Generation:**
    *   User successfully ran `calculate.sh` to generate job scripts.
    *   User compiled `compute_pi.c` and `compute_pi_mpi.c` (assumed).
    *   User submitted jobs to Grace and collected raw output into `job_output.txt` (primarily for Part 1).
*   **Part 1 Data Processing & Analysis (User-driven with `main.py`):**
    *   User created `main.py` to parse `job_output.txt`.
    *   `main.py` successfully processes data for Part 1 experiments (n=10^8 and n=10^10) and error analysis (Part 1, Q4).
    *   `main.py` calculates execution times, speedups, and efficiencies.
    *   `main.py` identifies optimal thread counts (`p`) for different problem sizes (`n`).
    *   `main.py` generates plots for Part 1 analysis:
        *   `experiment_1_analysis.png` (includes time, speedup, efficiency for n=10^8)
        *   `experiment_2_execution_time.png` (for n=10^10)
        *   `error_vs_problem_size.png`
    *   `main.py` generates a `performance_summary.csv` file.
    *   `main.py` outputs textual answers for questions 1.4, 2.1, 2.2, and 3 from Part 1.
*   **Dependencies Managed:**
    *   User installed `pandas`, `matplotlib`, and `numpy` using `uv`.
*   **Documentation Directory Created:**
    *   Successfully created the `docs/` directory using `mkdir -p docs`.
