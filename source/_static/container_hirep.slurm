#!/bin/bash
#SBATCH -N  2
#SBATCH -n  128

export PMIX_MCA_psec=native

srun --mpi=pmix singularity run -B /users,/scratch hirep.sif /hirep/TestProgram/DiracOperator/speed_test_diracoperator -i hirep_input_file -o hirep_output_file
