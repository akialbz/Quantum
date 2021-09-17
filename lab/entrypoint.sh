#!/usr/bin/env bash
set -e

if [[ $1 == 'jupyter' ]]; then
    jupyter lab --ip=0.0.0.0 --allow-root --no-browser 
elif [[ $1 == 'python' ]]; then
    python3
else
    $1
fi
