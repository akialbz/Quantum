#!/usr/bin/env bash
set -e

if [[ $1 == 'jupyter' ]]; then
    jupyter lab --ip=0.0.0.0 --allow-root --LabApp.token='' --no-browser 
elif [[ $1 == 'rstudio' ]]; then
    /usr/lib/rstudio-server/bin/rserver --server-daemonize=0
elif [[ $1 == 'python' ]]; then
    python3
elif [[ $1 == 'r' ]]; then
    R
else
    bash
fi
