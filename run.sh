#!/bin/sh

libbi sample @config.conf @posterior.conf --filter kalman --output-file results/posterior_kalman.nc
libbi sample @config.conf @posterior.conf --filter bootstrap --output-file results/posterior_bootstrap.nc
libbi sample @config.conf @posterior.conf --filter bridge --output-file results/posterior_bridge.nc
