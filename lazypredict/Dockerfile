#
# Dedicated Lazypredict image
#
# author(s): Albert (aki) Zhou
# origin: 13-09-2021
#

FROM akialbz/quantum:base

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libgomp1 \
       build-essential

# Install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir lazypredict

# clean
RUN set -ex \
    && apt-get purge -y \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
