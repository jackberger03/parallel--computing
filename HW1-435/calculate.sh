# Extended Experiment 6: Test higher ntasks-per-node values

# File 1: exp6_ntasks16.grace_job
cat > exp6_ntasks16.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks16
#SBATCH --time=0:30:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks16_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=16 (4 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

# File 2: exp6_ntasks32.grace_job  
cat > exp6_ntasks32.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks32
#SBATCH --time=0:30:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks32_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=32 (2 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

# File 3: exp6_ntasks64.grace_job
cat > exp6_ntasks64.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks64
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks64_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=64 (1 node) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

echo "Created extended Experiment 6 batch files"
echo ""
echo "Submit with:"
echo "  sbatch exp6_ntasks16.grace_job"
echo "  sbatch exp6_ntasks32.grace_job" 
echo "  sbatch exp6_ntasks64.grace_job"
echo ""
echo "This will test the complete optimization space:"
echo "  ntasks-per-node = 1,2 → FAILED (too many nodes)"
echo "  ntasks-per-node = 4   → 16 nodes (working)"
echo "  ntasks-per-node = 8   → 8 nodes (current optimum)"
echo "  ntasks-per-node = 16  → 4 nodes (test)"
echo "  ntasks-per-node = 32  → 2 nodes (test)"
echo "  ntasks-per-node = 64  → 1 node (test)"