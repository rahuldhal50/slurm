#!/bin/bash

## specify the job and project name
#SBATCH --job-name=package_installation_job

## specify the required resources
#SBATCH --nodes=1
#SBATCH --output=/nfs/users/ext_example.user/test/slurmjob.%J.out
####SBATCH --partition=default-long
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1Gb
#SBATCH --time=0-00:05:00

#
# add your command here, e.g
#
sleep 300
#spack load gcc@10.1.0
#spack load python@3.7.7
#spack install py-raven
#spack install py-torch@1.3.0 ^cuda@10.2.0 
