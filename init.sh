#!/bin/sh

# generate data sets
libbi sample @config.conf @prepare_obs.conf
octave --path oct -q --eval "prepare_obs;"
