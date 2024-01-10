#
# Kagami framework for algorithm development 
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM ubuntu:jammy


# install dependencies
RUN set -ex \
    && apt update \
    && apt install -y --no-install-recommends \
       libblas-dev \
       liblapack-dev \
       libhdf5-dev \
       libssl-dev \
       libffi-dev \
       python3-dev \
       build-essential \
       curl \
       wget \
       python3-pip


# install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip setuptools wheel 

RUN set -ex \
    && pip3 install --no-cache-dir \
       # base
       requests \
       pysocks \
       hypothesis \
       typing-extensions \
       pytest \
       pooch \
       # numeric
       numpy==1.25.2 \
       scipy \
       pandas \
       tables \
       bottleneck \
       # homebrew
       kagami>=3.2.2


# clean apt
RUN set -ex \
    && apt --purge autoremove -y \
    && apt autoclean -y \
    && apt clean -y \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set dirs
# alias Python
RUN ln -s /usr/bin/python3 /usr/bin/python

# python lib dir
RUN mkdir -p /home/share/python/dist-packages/
ENV PYTHONPATH /home/share/python/dist-packages/

# work dir(s)
RUN mkdir -p /home/docker/
WORKDIR /home/docker/


# set entry
CMD bash
