#!/bin/bash
#SBATCH --job-name=test
#SBATCH --gres gpu:8
#SBATCH --nodes 1 
#####SBATCH --nodelist p3-r50-b.g42cloud.net 
#SBATCH --partition=batch
#SBATCH --time=00-01:30:00

eval "$(/nfs/users/ext_example.user/anaconda3/bin/conda shell.bash hook)"
cd DomainBed
python -m domainbed.scripts.sweep launch --data_dir=./domainbed/data/ --output_dir=./domainbed/ERM_check/ --command_launcher multi_gpu  --algorithms ERM --datasets PACS --n_hparams 5  --n_trials 3 --skip_confirmation 
