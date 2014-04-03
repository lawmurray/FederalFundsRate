#!/bin/sh

# set data
libbi filter @config.conf @filter_set.conf --filter bootstrap --output-file results/filter_set_bootstrap.nc
libbi sample @config.conf @posterior_set.conf --filter bootstrap --output-file results/posterior_set_bootstrap.nc

# FFR data
libbi filter @config.conf @filter_ffr.conf --filter bootstrap --output-file results/filter_ffr_bootstrap.nc
libbi sample @config.conf @posterior_ffr.conf --filter bootstrap --output-file results/posterior_ffr_bootstrap.nc
