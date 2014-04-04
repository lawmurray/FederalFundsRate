#!/bin/sh

libbi filter @config.conf @filter.conf --filter bootstrap --output-file results/filter_bootstrap.nc
libbi filter @config.conf @filter.conf --filter bridge --output-file results/filter_bridge.nc
libbi sample @config.conf @posterior.conf
