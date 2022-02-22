#
# Modified from official R Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM debian:bullseye-slim

# install dependencies
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
       libzmq5 \
       libzmq5-dev \
       libunwind8 \
       libunwind-dev \
       libfreetype6 \
       libfreetype6-dev \
       zlib1g \
       zlib1g-dev \
       git \
       locales \
       gnupg \
       curl \
       wget \
       default-jre \
       default-jdk \
       build-essential

RUN set -ex \
    && wget --no-check-certificate https://github.com/jgm/pandoc/releases/download/2.14.2/pandoc-2.14.2-linux-amd64.tar.gz \
    && tar -zxf pandoc-2.14.2-linux-amd64.tar.gz \
    && mv pandoc-2.14.2/bin/* /usr/local/bin/ \
    && mkdir -p /usr/local/share/man/man1/ \
    && mv pandoc-2.14.2/share/man/man1/* /usr/local/share/man/man1/ \
    && rm -rf pandoc-2.14.2

# install latest R
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN set -ex \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN set -ex \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' \
    && echo "deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t bullseye-cran40 -y --no-install-recommends \
       r-base \
       r-base-dev

# install R packages
RUN R CMD javareconf
RUN R -e 'install.packages(c( \
            # utils
            "devtools", \
            "rJava", \
            # data manipulation
            "tidyverse", \
            "dplyr", \
            # matrix decomposition
            "RGCCA", \
            "umap", \
            # graph
            "igraph", \
            "dynamicTreeCut", \
            # machine learning 
            "caret", \
            "mlr", \
            "kernlab", \
            "randomForest", \
            "rpart", \
            "bartMachine", \
            # ecology
            "vegan", \
            "ade4", \
            # single cell
            "Seurat", \
            # visualisation
            "factoextra", \
            "pheatmap", \
            "gplots", \
            "plotly" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN set -ex \
    && apt-get install -y --no-install-recommends harfbuzz fribidi

RUN R -e 'install.packages("BiocManager"); \
          BiocManager::install(c( \
            # RNA-Seq
            "DESeq2", \
            "GSEABase", \
            "limma", \
            "sva", \
            # single cell
            "scater", \
            "harmony", \
            # multiomics
            "mixOmics", \
            "omicade4", \
            "MOFA2", \
            "MOFAdata", \
            # graph
            "WGCNA" \
          ), suppressUpdates = F, ask = F, clean = T)'

RUN R -e 'devtools::install_github("isglobal-brge/rexposome"); \
          devtools::install_github("isglobal-brge/omicRexposome")'

# clean
RUN set -ex \
    && apt-get purge -y \
       libzmq5-dev \
       libunwind-dev \
       libfreetype6-dev \
       libblas-dev \
       liblapack-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       libssl-dev \
       libpng-dev \
       libjpeg62-turbo-dev \
       zlib1g-dev \
       r-base-dev \
       curl \
       wget \
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
CMD R
