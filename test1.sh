#!/bin/bash 

#SBATCH --gres=gpu:16
#SBATCH --nodes=2
#SBATCH --partition=special
#SBATCH --qos=high
hostname
nvidia-smi
sleep 20
