#
# Kagami framework for algorithm development 
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM python:3.9-slim-bullseye


# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libblas3 \
       libblas-dev \
       liblapack3 \
       liblapack-dev \
       libhdf5-dev \
       build-essential


# install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
       # base
       requests \
       pysocks \
       hypothesis \
       typing-extensions \
       pytest \
       # numeric
       numpy \
       scipy \
       pandas \
       tables \
       bottleneck \
       # homebrew
       kagami>=3.1.0


# clean apt
RUN set -ex \
    && apt-get purge -y \
       libblas-dev \
       liblapack-dev \
       libhdf5-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set dirs
# python lib dir
RUN mkdir -p /home/share/python/dist-packages/
ENV PYTHONPATH /home/share/python/dist-packages/

# work dir(s)
RUN mkdir -p /home/docker/
WORKDIR /home/docker/


# set entry
CMD bash
