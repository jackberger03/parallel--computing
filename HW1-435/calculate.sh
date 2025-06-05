#!/bin/bash
# Complete MPI batch files for CSCE 435 HW1 Part 2

echo "Creating MPI batch files for all experiments..."

# =======================================================
# Batch File 1: compute_pi_mpi_exp5.grace_job
# Experiment 5: n=10^8, p=2^k (k=0-6), ntasks-per-node=4
# =======================================================

cat > compute_pi_mpi_exp5.grace_job << 'EOF'
#!/bin/bash
##ENVIRONMENT SETTINGS; CHANGE WITH CAUTION
#SBATCH --export=NONE            #Do not propagate environment
#SBATCH --get-user-env=L         #Replicate login environment
#
##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=MPI_Exp5      #Set the job name
#SBATCH --time=1:00:00           #Set the wall clock limit
#SBATCH --nodes=16               #Request 16 nodes
#SBATCH --ntasks-per-node=4      #Request 4 tasks/cores per node
#SBATCH --mem=8G                 #Request 8GB per node 
#SBATCH --output=mpi_exp5_output.%j #Send stdout/err to output file
#
##First Executable Line
#
module load intel               # load Intel software stack 

# Compile MPI version
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 5: n=10^8, varying p (ntasks-per-node=4) ==="
echo "n = 100000000"

# Run for p = 2^k, k = 0 to 6 (p = 1, 2, 4, 8, 16, 32, 64)
echo "Processes = 1"
mpirun -np 1 ./compute_pi_mpi.exe 100000000

echo "Processes = 2" 
mpirun -np 2 ./compute_pi_mpi.exe 100000000

echo "Processes = 4"
mpirun -np 4 ./compute_pi_mpi.exe 100000000

echo "Processes = 8"
mpirun -np 8 ./compute_pi_mpi.exe 100000000

echo "Processes = 16"
mpirun -np 16 ./compute_pi_mpi.exe 100000000

echo "Processes = 32"
mpirun -np 32 ./compute_pi_mpi.exe 100000000

echo "Processes = 64"
mpirun -np 64 ./compute_pi_mpi.exe 100000000

echo "=== Experiment 5 Complete ==="
EOF

# =======================================================
# Batch File 2: compute_pi_mpi_exp6.grace_job  
# Experiment 6: n=10^10, p=64, varying ntasks-per-node
# =======================================================

cat > compute_pi_mpi_exp6.grace_job << 'EOF'
#!/bin/bash
##ENVIRONMENT SETTINGS; CHANGE WITH CAUTION
#SBATCH --export=NONE            #Do not propagate environment
#SBATCH --get-user-env=L         #Replicate login environment
#
##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=MPI_Exp6      #Set the job name
#SBATCH --time=2:00:00           #Set the wall clock limit
#SBATCH --nodes=64               #Request enough nodes for flexibility
#SBATCH --mem=8G                 #Request 8GB per node 
#SBATCH --output=mpi_exp6_output.%j #Send stdout/err to output file
#
##First Executable Line
#
module load intel               # load Intel software stack 

echo "=== Experiment 6: n=10^10, p=64, varying ntasks-per-node ==="
echo "n = 10000000000, p = 64"

# Test different ntasks-per-node values
# We need 64 total processes, so:
# ntasks-per-node=1 → 64 nodes
# ntasks-per-node=2 → 32 nodes  
# ntasks-per-node=4 → 16 nodes
# ntasks-per-node=8 → 8 nodes
# ntasks-per-node=16 → 4 nodes
# ntasks-per-node=32 → 2 nodes
# ntasks-per-node=64 → 1 node

echo "ntasks-per-node = 1 (64 nodes)"
srun --nodes=64 --ntasks-per-node=1 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 2 (32 nodes)"  
srun --nodes=32 --ntasks-per-node=2 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 4 (16 nodes)"
srun --nodes=16 --ntasks-per-node=4 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 8 (8 nodes)"
srun --nodes=8 --ntasks-per-node=8 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 16 (4 nodes)"
srun --nodes=4 --ntasks-per-node=16 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 32 (2 nodes)"
srun --nodes=2 --ntasks-per-node=32 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "ntasks-per-node = 64 (1 node)"
srun --nodes=1 --ntasks-per-node=64 --ntasks=64 ./compute_pi_mpi.exe 10000000000

echo "=== Experiment 6 Complete ==="
EOF

# =======================================================
# Batch File 3: compute_pi_mpi_exp7.grace_job
# Experiment 7: p=64 and p=1, varying n, ntasks-per-node=4
# =======================================================

cat > compute_pi_mpi_exp7.grace_job << 'EOF'
#!/bin/bash
##ENVIRONMENT SETTINGS; CHANGE WITH CAUTION
#SBATCH --export=NONE            #Do not propagate environment
#SBATCH --get-user-env=L         #Replicate login environment
#
##NECESSARY JOB SPECIFICATIONS
#SBATCH --job-name=MPI_Exp7      #Set the job name
#SBATCH --time=1:30:00           #Set the wall clock limit
#SBATCH --nodes=16               #Request 16 nodes
#SBATCH --ntasks-per-node=4      #Request 4 tasks/cores per node
#SBATCH --mem=8G                 #Request 8GB per node 
#SBATCH --output=mpi_exp7_output.%j #Send stdout/err to output file
#
##First Executable Line
#
module load intel               # load Intel software stack 

echo "=== Experiment 7: varying n, ntasks-per-node=4 ==="

# Test n = 10^2, 10^4, 10^6, 10^8 with both p=1 and p=64

echo "--- p=1 runs (for speedup calculation) ---"

echo "p=1, n=100"
mpirun -np 1 ./compute_pi_mpi.exe 100

echo "p=1, n=10000"  
mpirun -np 1 ./compute_pi_mpi.exe 10000

echo "p=1, n=1000000"
mpirun -np 1 ./compute_pi_mpi.exe 1000000

echo "p=1, n=100000000"
mpirun -np 1 ./compute_pi_mpi.exe 100000000

echo "--- p=64 runs ---"

echo "p=64, n=100"
mpirun -np 64 ./compute_pi_mpi.exe 100

echo "p=64, n=10000"
mpirun -np 64 ./compute_pi_mpi.exe 10000

echo "p=64, n=1000000" 
mpirun -np 64 ./compute_pi_mpi.exe 1000000

echo "p=64, n=100000000"
mpirun -np 64 ./compute_pi_mpi.exe 100000000

echo "=== Experiment 7 Complete ==="
EOF

# Make all scripts executable
chmod +x *.grace_job

echo ""
echo "Created MPI batch files:"
echo "  1. compute_pi_mpi_exp5.grace_job - Experiment 5 (n=10^8, varying p)"
echo "  2. compute_pi_mpi_exp6.grace_job - Experiment 6 (n=10^10, p=64, varying ntasks-per-node)"
echo "  3. compute_pi_mpi_exp7.grace_job - Experiment 7 (varying n, p=1 and p=64)"
echo ""
echo "To run:"
echo "  sbatch compute_pi_mpi_exp5.grace_job"
echo "  sbatch compute_pi_mpi_exp6.grace_job" 
echo "  sbatch compute_pi_mpi_exp7.grace_job"
echo ""
echo "Note: Make sure compute_pi_mpi.c is in your directory before running!"
echo "The MPI version should be compiled with: mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c"