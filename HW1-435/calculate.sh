# Create separate batch files for each ntasks-per-node configuration

# File 1: exp6_ntasks1.grace_job
cat > exp6_ntasks1.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks1
#SBATCH --time=0:30:00
#SBATCH --nodes=64
#SBATCH --ntasks-per-node=1
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks1_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=1 (64 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

# File 2: exp6_ntasks2.grace_job
cat > exp6_ntasks2.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks2
#SBATCH --time=0:30:00
#SBATCH --nodes=32
#SBATCH --ntasks-per-node=2
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks2_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=2 (32 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

# File 3: exp6_ntasks4.grace_job
cat > exp6_ntasks4.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks4
#SBATCH --time=0:30:00
#SBATCH --nodes=16
#SBATCH --ntasks-per-node=4
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks4_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=4 (16 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

# File 4: exp6_ntasks8.grace_job
cat > exp6_ntasks8.grace_job << 'EOF'
#!/bin/bash
#SBATCH --export=NONE
#SBATCH --get-user-env=L
#SBATCH --job-name=MPI_Exp6_ntasks8
#SBATCH --time=0:30:00
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=8
#SBATCH --mem=8G
#SBATCH --output=exp6_ntasks8_output.%j

module load intel
mpiicx -o compute_pi_mpi.exe compute_pi_mpi.c

echo "=== Experiment 6: ntasks-per-node=8 (8 nodes) ==="
echo "n = 10000000000, p = 64"
mpirun -np 64 ./compute_pi_mpi.exe 10000000000
EOF

echo "Created 4 separate batch files for Experiment 6"
echo "Submit them with:"
echo "  sbatch exp6_ntasks1.grace_job"
echo "  sbatch exp6_ntasks2.grace_job" 
echo "  sbatch exp6_ntasks4.grace_job"
echo "  sbatch exp6_ntasks8.grace_job"