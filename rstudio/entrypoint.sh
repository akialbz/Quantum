#!/usr/bin/env bash
set -e

if [[ $1 == 'rstudio' ]]; then
    /usr/lib/rstudio-server/bin/rserver --server-daemonize=0
else
    $1
fi
