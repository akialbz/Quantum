#
# Modified from official Python and R Dockerfiles
# Python and R packages for ML included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:lab

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libzmq5 \
       libzmq5-dev \
       curl \
       build-essential

# config Jupyter
COPY passwdcfg /usr/local/
RUN set -ex \
    && rm /root/.jupyter/jupyter_server_config.json \
    && cp /root/.jupyter/jupyter_server_config.json.bk /root/.jupyter/jupyter_server_config.json \
    && cat /usr/local/passwdcfg >> /root/.jupyter/jupyter_server_config.json \
    && rm /usr/local/passwdcfg

# install beamspy kernel
RUN set -ex \
    && conda create -n beamspy beamspy python=3 -c conda-forge -c bioconda -c computational-metabolomics \
    && conda run --no-capture-output -n beamspy \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n beamspy \
       python -m ipykernel install --user --name=beamspy \
    && conda clean --all --yes

# clean
RUN set -ex \
    && apt-get purge -y \
       libzmq5-dev \
       curl \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
