#!/bin/bash

## specify the job and project name
#SBATCH --job-name=test_job

## specify the required resources
#SBATCH --nodes=2
#SBATCH --output=/nfs/users/ext_example.user/test/slurmjob.%J.out
####SBATCH --partition=batch
#SBATCH --nodelist=p4-r82-b.g42cloud.net,p4-r81-a.g42cloud.net
######SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem=100Gb
#SBATCH --time=0-00:15:00
#SBATCH --ntasks=16
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nfs/shared/nccl/nccl/build/lib
export LD_LIBRARY_PATH=/nfs/shared/openmpi-4.1.3/lib:/usr/lib64/:$LD_LIBRARY_PATH
export PATH=/nfs/shared/openmpi-4.1.3/bin:/usr/bin/:$PATH

#
# add your command here, e.g
#
cd /nfs/shared/nccl/nccl-tests
/nfs/shared/openmpi-4.1.3/bin/mpirun -np 20 ./build/all_reduce_perf -b 8 -e 128M -f 2 -g 4
#spack load gcc@10.1.0
#spack load python@3.7.7
#spack install py-raven
#spack install py-torch@1.3.0 ^cuda@10.2.0 
