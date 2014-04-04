#!/bin/sh

# set data
libbi filter @config.conf @filter_set.conf --filter bridge --output-file results/filter_set_bridge.nc

# FFR data
libbi filter @config.conf @filter_ffr.conf --filter bridge --output-file results/filter_ffr_bridge.nc
libbi sample @config.conf @posterior_ffr.conf --filter bridge --output-file results/posterior_ffr_bridge.nc
