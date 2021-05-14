#
# Modified from official Python Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.9-slim-buster

# Add new user
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && useradd -m -d /home/docker -U docker \
    && echo "docker:passwd" | chpasswd \
    && adduser docker sudo \
    && addgroup docker staff

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libhdf5-dev

# Install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       numpy \
       scipy \
       pandas \
       tables \
       scikit-learn \
       imbalanced-learn \
       statsmodels \
       matplotlib \
       plotly \
       networkx \
       requests \
       pysocks \
       hypothesis \       
       pytest

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
    && mkdir -p /home/docker/ \
    && mkdir -p /home/shared_library
ENV PYTHONPATH /home/shared_library

# set entry
WORKDIR /home/docker/
CMD ["python3"]
