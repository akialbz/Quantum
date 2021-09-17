#
# Modified from official R Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM debian:bullseye-slim

# Add new user
COPY passwd /usr/local/
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && useradd -m -d /home/docker -U docker \
    && cat /usr/local/passwd | chpasswd \
    && adduser docker sudo \
    && addgroup docker staff \
    && rm /usr/local/passwd

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libblas3 \
       libblas-dev \
       liblapack3 \
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
       locales \
       gnupg \
       build-essential

# Install latest R
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN set -ex \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN set -ex \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
    && echo "deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t bullseye-cran40 -y --no-install-recommends \
       r-base \
       r-base-dev

# Install R packages
RUN R -e 'install.packages(c( \
              "devtools", \
              "dynamicTreeCut", \
              "RGCCA", \
              "igraph", \
              "tidyverse", \
              "dplyr", \
              "caret", \
              "gplots", \
              "plotly" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN R -e 'install.packages("BiocManager"); \
          BiocManager::install(c( \
              "WGCNA", \
              "DESeq2", \
              "limma", \
              "sva", \
              "mixOmics" \
          ), suppressUpdates = F, ask = F, clean = T)'

# clean
RUN set -ex \
    && apt-get purge -y \
       libblas-dev \
       liblapack-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       libssl-dev \
       libpng-dev \
       libjpeg62-turbo-dev \
       zlib1g-dev \
       r-base-dev \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
        
# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/project/ 

# set entry
WORKDIR /home/docker/project/
CMD ["R"]
