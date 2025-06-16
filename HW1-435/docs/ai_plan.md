# AI Plan for CSCE 435 HW1

This plan outlines the steps the AI assistant (Cascade) will take to help complete the assignment.

## Current Phase: Part 1 Analysis & Documentation Update

1.  **DONE:** Assist in generating SLURM job scripts (`calculate.sh`) for all experiments in Part 1 and Part 2.
2.  **DONE:** User has run jobs and provided output in `job_output.txt`.
3.  **DONE:** User has created `main.py` to parse `job_output.txt`, perform calculations, generate plots, and answer questions for Part 1.
4.  **DONE:** User has confirmed `main.py` functionality for Part 1 analysis and provided output.
5.  **DONE:** Reviewed user-provided output from `main.py` and confirmed answers to specific questions from Part 1 (1.1-1.4, 2.1-2.2, 3).
6.  **DONE:** Explicitly created the `docs/` directory.
7.  **CURRENT:** Update documentation files (`ProjectPlan.md`, `ai_plan.md`, `past.md`, `future.md`, `context.md`) to reflect current progress and project structure.

## Next Phase: Part 2 Analysis

1.  **TODO:** Guide the user to adapt `main.py` or create a new script to parse the output for Part 2 MPI experiments.
    *   This will involve parsing different output formats if `compute_pi_mpi.c` produces different log lines.
    *   The script will need to handle data for questions 5, 6, and 7.
2.  **TODO:** Assist in implementing calculations for Part 2:
    *   Execution time vs. `p` (Q5.1)
    *   Speedup vs. `p` (Q5.2) (Requires `p=1` baseline for MPI)
    *   Efficiency vs. `p` (Q5.3)
    *   Optimal `p` (Q5.4)
    *   Time vs. `ntasks-per-node` (Q6)
    *   Speedup vs. `n` for `p=64` (Q7.1) (Requires `p=1` baselines for various `n`)
    *   Relative error vs. `n` (Q7.2)
3.  **TODO:** Assist in generating plots for Part 2 questions.
4.  **TODO:** Help formulate textual answers for all Part 2 questions based on the processed data and plots.

## Final Phase: Report Compilation

1.  **TODO:** Advise on structuring the final report document.
2.  **TODO:** Ensure all questions are answered and all required plots are included.

## General Approach

*   Prioritize user requests.
*   Use tools (e.g., `write_to_file`, `replace_file_content`) to create and modify files.
*   Maintain and update documentation files (`docs/*.md`) regularly after confirmed progress.
*   Adhere to user-defined rules, especially regarding code quality and package managers (`uv`, `npm`).
