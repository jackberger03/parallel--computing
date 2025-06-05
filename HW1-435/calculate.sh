#!/bin/bash
# Collection of batch scripts for CSCE 435 HW1 experiments

# ===========================================
# Part 1: Shared-Memory (Threads) Experiments
# ===========================================

# Script 1: compute_pi_threads_exp1.grace_job
# For experiments 1.1-1.4: n=10^8, p=2^k (k=0-13)
cat > compute_pi_threads_exp1.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_threads_exp1
#SBATCH --output=pi_threads_exp1_%j.out
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8192
#SBATCH --exclusive

module load intel

# Compile the program
icx -o compute_pi.exe compute_pi.c -lpthread

# Experiment parameters
n=100000000  # 10^8

echo "Part 1 Experiments: n=$n"
echo "p,time,pi,error" > results_threads_exp1.csv

# Run experiments for p = 2^k, k = 0 to 13
for k in {0..13}; do
    p=$((2**k))
    echo "Running with n=$n, p=$p"
    
    # Run the program and capture output
    output=$(./compute_pi.exe $n $p)
    
    # Extract time from output (assuming format: "time (sec) = X.XXXX")
    time=$(echo "$output" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi=$(echo "$output" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    error=$(echo "$output" | grep -o 'error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    
    echo "$p,$time,$pi,$error" >> results_threads_exp1.csv
    echo "p=$p: time=$time, pi=$pi, error=$error"
done

echo "Experiment 1 completed. Results saved to results_threads_exp1.csv"
EOF

# Script 2: compute_pi_threads_exp2.grace_job
# For experiment 2: n=10^10, p=2^k (k=0-13)
cat > compute_pi_threads_exp2.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_threads_exp2
#SBATCH --output=pi_threads_exp2_%j.out
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8192
#SBATCH --exclusive

module load intel

# Use previously compiled program
n=10000000000  # 10^10

echo "Part 1 Experiment 2: n=$n"
echo "p,time,pi,error" > results_threads_exp2.csv

for k in {0..13}; do
    p=$((2**k))
    echo "Running with n=$n, p=$p"
    
    output=$(./compute_pi.exe $n $p)
    time=$(echo "$output" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi=$(echo "$output" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    error=$(echo "$output" | grep -o 'error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    
    echo "$p,$time,$pi,$error" >> results_threads_exp2.csv
    echo "p=$p: time=$time, pi=$pi, error=$error"
done

echo "Experiment 2 completed. Results saved to results_threads_exp2.csv"
EOF

# Script 3: compute_pi_threads_exp4.grace_job
# For experiment 4: Error vs n analysis, p=48
cat > compute_pi_threads_exp4.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_threads_exp4
#SBATCH --output=pi_threads_exp4_%j.out
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --exclusive

module load intel

p=48  # Fixed number of threads

echo "Part 1 Experiment 4: Error vs n, p=$p"
echo "n,time,pi,error" > results_threads_exp4.csv

# Test different values of n: 10^k for k=3 to 9
for k in {3..9}; do
    n=$((10**k))
    echo "Running with n=$n, p=$p"
    
    output=$(./compute_pi.exe $n $p)
    time=$(echo "$output" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi=$(echo "$output" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    error=$(echo "$output" | grep -o 'error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    
    echo "$n,$time,$pi,$error" >> results_threads_exp4.csv
    echo "n=$n: time=$time, pi=$pi, error=$error"
done

echo "Experiment 4 completed. Results saved to results_threads_exp4.csv"
EOF

# ===========================================
# Part 2: Distributed-Memory (MPI) Experiments
# ===========================================

# Script 4: compute_pi_mpi_exp5.grace_job
# For experiments 5.1-5.4: n=10^8, p=2^k (k=0-6)
cat > compute_pi_mpi_exp5.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_mpi_exp5
#SBATCH --output=pi_mpi_exp5_%j.out
#SBATCH --time=01:00:00
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=16
#SBATCH --exclusive

module load intel

# Compile MPI program
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

n=100000000  # 10^8

echo "Part 2 Experiment 5: n=$n"
echo "p,time,pi,relative_error" > results_mpi_exp5.csv

# Run experiments for p = 2^k, k = 0 to 6
for k in {0..6}; do
    p=$((2**k))
    echo "Running with n=$n, p=$p"
    
    # Run MPI program
    output=$(mpirun -np $p ./compute_pi_mpi.exe $n)
    
    # Extract data from output
    time=$(echo "$output" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi=$(echo "$output" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    rel_error=$(echo "$output" | grep -o 'relative error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    
    echo "$p,$time,$pi,$rel_error" >> results_mpi_exp5.csv
    echo "p=$p: time=$time, pi=$pi, relative_error=$rel_error"
done

echo "Experiment 5 completed. Results saved to results_mpi_exp5.csv"
EOF

# Script 5: compute_pi_mpi_exp6.grace_job
# For experiment 6: Optimize ntasks-per-node, n=10^10, p=64
cat > compute_pi_mpi_exp6.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_mpi_exp6
#SBATCH --output=pi_mpi_exp6_%j.out
#SBATCH --time=02:00:00
#SBATCH --nodes=4
#SBATCH --exclusive

module load intel

n=10000000000  # 10^10
p=64

echo "Part 2 Experiment 6: n=$n, p=$p"
echo "ntasks_per_node,time,pi,relative_error" > results_mpi_exp6.csv

# Test different ntasks-per-node values
for ntasks in 1 2 4 8 16 32; do
    echo "Running with ntasks-per-node=$ntasks"
    
    # Calculate required nodes
    nodes=$(( (p + ntasks - 1) / ntasks ))
    
    if [ $nodes -le 4 ]; then  # Ensure we don't exceed allocated nodes
        # Modify SLURM settings for this run
        export SLURM_NTASKS_PER_NODE=$ntasks
        
        output=$(mpirun -np $p ./compute_pi_mpi.exe $n)
        
        time=$(echo "$output" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
        pi=$(echo "$output" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
        rel_error=$(echo "$output" | grep -o 'relative error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
        
        echo "$ntasks,$time,$pi,$rel_error" >> results_mpi_exp6.csv
        echo "ntasks-per-node=$ntasks: time=$time"
    fi
done

echo "Experiment 6 completed. Results saved to results_mpi_exp6.csv"
EOF

# Script 6: compute_pi_mpi_exp7.grace_job
# For experiment 7: Scalability analysis, p=64, different n values
cat > compute_pi_mpi_exp7.grace_job << 'EOF'
#!/bin/bash
#SBATCH --job-name=pi_mpi_exp7
#SBATCH --output=pi_mpi_exp7_%j.out
#SBATCH --time=01:00:00
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=16
#SBATCH --exclusive

module load intel

p=64

echo "Part 2 Experiment 7: p=$p, ntasks-per-node=4"
echo "n,time_p64,pi,relative_error" > results_mpi_exp7_p64.csv
echo "n,time_p1,pi,relative_error" > results_mpi_exp7_p1.csv

# Test different n values: 10^2, 10^4, 10^6, 10^8
for k in 2 4 6 8; do
    n=$((10**k))
    echo "Running with n=$n"
    
    # Run with p=64
    echo "  p=64..."
    output64=$(mpirun -np 64 ./compute_pi_mpi.exe $n)
    time64=$(echo "$output64" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi64=$(echo "$output64" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    rel_error64=$(echo "$output64" | grep -o 'relative error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    echo "$n,$time64,$pi64,$rel_error64" >> results_mpi_exp7_p64.csv
    
    # Run with p=1 for speedup calculation
    echo "  p=1..."
    output1=$(mpirun -np 1 ./compute_pi_mpi.exe $n)
    time1=$(echo "$output1" | grep -o 'time (sec) = [0-9.]*' | grep -o '[0-9.]*$')
    pi1=$(echo "$output1" | grep -o 'pi = [0-9.]*' | grep -o '[0-9.]*$')
    rel_error1=$(echo "$output1" | grep -o 'relative error = [0-9.e-]*' | grep -o '[0-9.e-]*$')
    echo "$n,$time1,$pi1,$rel_error1" >> results_mpi_exp7_p1.csv
    
    echo "n=$n: time_p64=$time64, time_p1=$time1"
done

echo "Experiment 7 completed. Results saved to results_mpi_exp7_*.csv"
EOF

echo "All batch scripts created successfully!"
echo ""
echo "To run the experiments:"
echo "1. sbatch compute_pi_threads_exp1.grace_job"
echo "2. sbatch compute_pi_threads_exp2.grace_job" 
echo "3. sbatch compute_pi_threads_exp4.grace_job"
echo "4. sbatch compute_pi_mpi_exp5.grace_job"
echo "5. sbatch compute_pi_mpi_exp6.grace_job"
echo "6. sbatch compute_pi_mpi_exp7.grace_job"