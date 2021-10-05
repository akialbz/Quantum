#!/usr/bin/env bash
set -e

if [[ $1 == 'jupyter' ]]; then
    jupyter lab --ip=0.0.0.0 --allow-root --no-browser 
else
    $1
fi
