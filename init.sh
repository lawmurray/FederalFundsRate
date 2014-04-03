#!/bin/sh

# generate init files
octave --path oct -q --eval "prepare_init;"

# generate simulated data sets
libbi sample @config.conf @prepare_obs.conf
octave --path oct -q --eval "prepare_obs;"
