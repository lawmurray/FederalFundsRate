#!/bin/sh
#PBS -l walltime=02:00:00,nodes=1:ppn=2,vmem=8gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

SEED=$PBS_ARRAYID
INIT_NP=$PBS_ARRAYID

libbi test_filter @config.conf @test_filter.conf --filter bridge --output-file results/test_bridge-$INIT_NP.nc --seed $SEED --init-np $INIT_NP
