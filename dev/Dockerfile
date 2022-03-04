#
# General docker image for algorithm development
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.9-slim-bullseye

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libhdf5-dev \
       build-essential

# install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
       hypothesis \
       pytest \
       numpy \
       scipy \
       pandas \
       statsmodels \
       scikit-learn \
       python-igraph \
       networkx \
       requests \
       pysocks \
       tables \
       kagami

# clean
RUN set -ex \
    && apt-get purge -y \
       libhdf5-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/
WORKDIR /home/docker/

# set entry
CMD bash
