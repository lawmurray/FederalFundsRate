#!/bin/sh
#PBS -l walltime=02:00:00,nodes=1:ppn=1,vmem=8gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

./run_bridge.sh
