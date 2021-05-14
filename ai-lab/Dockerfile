#
# Modified from official Python and R Dockerfiles for machine learning
# JupyterLab, RStudio, and ML packages included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:lab

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libblas-dev \
       liblapack-dev \
       libcurl4 \
       libcurl4-openssl-dev \
       libxml2 \
       libxml2-dev \
       libssl1.1 \                
       libssl-dev \
       libpng16-16 \
       libpng-dev \
       libjpeg62-turbo \
       libjpeg62-turbo-dev \
       zlib1g \
       zlib1g-dev \
       git \
       pkg-config \
       build-essential \
       gfortran \
    && ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/x86_64-linux-gnu/libgfortran.so 

# Install additional Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       kagami \
       seaborn \
       cython \
       pydotplus \ 
       pyyaml \
       bokeh \
       eli5 \
       shap \
       xgboost \
       keras \
       Theano \
       lime \
    && pip3 install tensorflow==2.5.0rc0 \
    && pip3 install --no-cache-dir torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

# Install R packages
RUN R -e 'install.packages(c( \
              "devtools", \
              "caret", \
              "mlr3", \
              "randomForest", \
              "tidyverse", \
              "dplyr", \
              "h2o", \
              "iml", \
              "gplots", \
              "plotly" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN R -e 'install.packages("BiocManager"); \
          BiocManager::install(c( \
              "WGCNA", \
              "DESeq2", \
              "sva", \
              "mixOmics" \
          ), suppressUpdates = F, ask = F, clean = T)'

# clean
RUN set -ex \
    && apt-get purge -y \
       libcurl4-openssl-dev \
       libxml2-dev \
       libssl-dev \
       zlib1g-dev \
       libpng-dev \
       libblas-dev \
       liblapack-dev \
       libjpeg62-turbo-dev \
       build-essential \
       gfortran \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
