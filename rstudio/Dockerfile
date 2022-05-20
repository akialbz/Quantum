#
# RStudio server with bioinformatics packages included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM rocker/rstudio:latest

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
       libpcre2-8-0 \
       libpcre2-dev \
       libbz2-1.0 \
       libbz2-dev \
       liblzma5 \
       liblzma-dev \
       libjpeg-turbo8 \
       libjpeg-dev \
       libunwind8 \
       libunwind-dev \
       libfreetype6 \
       libfreetype6-dev \
       zlib1g \
       zlib1g-dev \
       cmake \
       gfortran \
       git \
       curl \
       wget \
       default-jre \
       default-jdk \
       libopenmpi-dev \
       build-essential

# install R packages
RUN R CMD javareconf
RUN R -e 'install.packages(c( \
            # utils
            "devtools", \
            "rJava", \
            "shiny" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN R -e 'install.packages(c( \
            # utils
            "devtools", \
            "rJava", \
            # data manipulation
            "reshape", \
            "tidyverse", \
            "dplyr", \
            # matrix decomposition
            "RGCCA", \
            "umap", \
            "Rtsne", \
            # graph
            "igraph", \
            "dynamicTreeCut", \
            # machine learning 
            "caret", \
            "mlr3", \
            "kernlab", \
            "randomForest", \
            "rpart", \
            "bartMachine", \
            # visualisation
            "factoextra", \
            "pheatmap", \
            "gplots", \
            "plotly", \
            # iRF
            "ranger", \
            "AUC", \
            "doMC", \
            "rgl", \
            "microbenchmark", \
            "profvis", \
            # xai
            "iml", \
            "lime" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN R -e 'install.packages("BiocManager"); \
          BiocManager::install(c( \
            # RNA-Seq
            "DESeq2", \
            "GSEABase", \
            "limma", \
            "sva", \
            # multiomics
            "mixOmics", \
            "omicade4", \
            "MOFA2", \
            "MOFAdata", \
            # graph
            "WGCNA" \
          ), suppressUpdates = F, ask = F, clean = T)'

RUN R -e 'devtools::install_github("isglobal-brge/rexposome"); \
          devtools::install_github("isglobal-brge/omicRexposome"); \
          devtools::install_github("karlkumbier/iRF2.0")'

# clean
RUN set -ex \
    && apt-get purge -y \
       libblas-dev \
       liblapack-dev \
       libcurl4-openssl-dev \
       libxml2-dev \
       libssl-dev \
       libpng-dev \
       libpcre2-dev \
       libbz2-dev \
       liblzma-dev \
       libjpeg-dev \
       libunwind-dev \
       libfreetype6-dev \
       zlib1g-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
