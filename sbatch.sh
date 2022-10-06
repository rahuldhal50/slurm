#!/bin/bash
#SBATCH --time=7-00:00:00 
#SBATCH --partition=special
#SBATCH --mem=0
#SBATCH --qos=high
#SBATCH --gpus=16
#SBATCH --nodes=1

nvidia-smi
sleep 10




