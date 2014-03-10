#!/bin/sh
#PBS -l walltime=00:30:00,nodes=1:ppn=1,vmem=8gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

libbi filter @config.conf @filter.conf --filter kalman --output-file results/filter_kalman.nc
libbi sample @config.conf @posterior.conf --filter kalman --output-file results/posterior_kalman.nc
