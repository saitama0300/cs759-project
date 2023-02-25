#!/usr/bin/env zsh

#SBATCH -p wacc

#SBATCH --job-name=FirstSlurm

#SBATCH -o FirstSlurm.out -e FirstSlurm.err

#SBATCH --cpus-per-task=2

#SBATCH --time=0-00:01:00

hostname