#!/bin/sh
#PBS -l walltime=08:00:00,nodes=1:ppn=1,vmem=8gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

SEED=$PBS_ARRAYID
INIT_NP=$PBS_ARRAYID

libbi test_filter @config.conf @test_filter.conf --filter bootstrap --output-file results/test_bootstrap-$INIT_NP.nc --seed $SEED --init-np $INIT_NP
