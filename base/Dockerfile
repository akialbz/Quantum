#
# Modified from official Python Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.10-slim-bullseye

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libhdf5-dev \
       libopenmpi-dev \
       curl \
       build-essential

# install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
       virtualenv \
       hypothesis \
       pytest \
       mpi4py \
       mpmath \
       numexpr \
       numpy \
       scipy \
       pandas \
       requests \
       pysocks \
       tables \
       kagami

# install conda
RUN set -ex \
    && curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -bfp /usr/local/conda/ \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/conda \
    && rm -rf miniconda.sh \
    && conda config --set auto_activate_base false

# clean
RUN set -ex \
    && apt-get purge -y \
       libhdf5-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/
WORKDIR /home/docker/

# set entry
CMD bash
