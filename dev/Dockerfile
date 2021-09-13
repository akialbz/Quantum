#
# Modified from official Python Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:base

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libhdf5-dev

# Install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       requests \
       pysocks \
       fastcluster \
       pandas \
       tables \
       statsmodels \
       seaborn \
       scikit-learn \
       imbalanced-learn \
       scikit-fuzzy \
       python-igraph \
       networkx \
       matplotlib \
       plotly \
       pyvis \
       kagami

# clean
RUN set -ex \
    && apt-get purge -y \
       libhdf5-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
