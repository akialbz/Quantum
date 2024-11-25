#
# Kagami framework for algorithm development 
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM ubuntu:noble


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
       gfortran \
       curl \
       wget \
       python3-pip


# install Python packages
RUN set -ex \
    && rm -rf /usr/lib/python3.*/EXTERNALLY-MANAGED \
    && pip3 install --no-cache-dir \
       # base
       setuptools \
       requests \
       pysocks \
       pooch \
       bottleneck \
       meson \
       Ninja \
       typing-extensions \
       # numeric
       numpy==1.26.4 \
       pandas==2.2.3 \
       tables \
       "pandas[performance]" \
       "pandas[hdf5]" \
       # test
       pytest \
       hypothesis \
       "pandas[test]" \
       # homebrew
       kagami==3.2.3


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
ENV PYTHONPATH=/home/share/python/dist-packages/

# work dir(s)
RUN mkdir -p /home/docker/
WORKDIR /home/docker/


# set entry
CMD bash
