#!/bin/sh
#PBS -l walltime=96:00:00,nodes=1:ppn=8,vmem=32gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

./run_bootstrap.sh
