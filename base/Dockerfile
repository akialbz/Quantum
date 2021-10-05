#
# Modified from official Python Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.9-slim-bullseye

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libhdf5-dev \
       libopenmpi-dev \
       build-essential

# Install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
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

# clean
RUN set -ex \
    && apt-get purge -y \
       libhdf5-dev \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/
WORKDIR /home/docker/

# set entry
RUN set -ex \
    && pip3 install --no-cache-dir ipython ipykernel
CMD python -m ipykernel_launcher -f $DOCKERNEL_CONNECTION_FILE
