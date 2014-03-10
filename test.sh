#!/bin/sh

libbi test_filter @config.conf @test_filter.conf --filter bootstrap --output-file results/test_bootstrap.nc
libbi test_filter @config.conf @test_filter.conf --filter bridge --output-file results/test_bridge.nc
