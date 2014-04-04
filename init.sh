#!/bin/sh

# sample parameters for testing
libbi sample --target prior --model-file OrnsteinUhlenbeckBridge.bi --nsamples 16 --output-file data/init_test_filter.nc

# generate init files
octave --path oct -q --eval "prepare_init;"
