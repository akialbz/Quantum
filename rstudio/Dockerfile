#
# RStudio app with DS/ML toolkits
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM rocker/rstudio:latest


# prepare env
RUN apt-get update
RUN apt-get install -y --no-install-recommends cmake


# install rJava
RUN apt-get install -y --no-install-recommends \
    libpcre2-dev \
    liblzma-dev \
    libbz2-dev \
    libz-dev \
    libicu-dev \
    libdeflate-dev \
    default-jdk

RUN set -ex \
    && R CMD javareconf \
    && install2.r --error -- --clean rJava Rcpp


# install R installers
RUN apt-get install -y --no-install-recommends \
    libfontconfig1-dev \
    libxml2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libgit2-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcurl4-openssl-dev

RUN install2.r --error -- --clean curl devtools BiocManager


# install CRAN packages
RUN apt-get install -y --no-install-recommends \
    libglpk-dev

RUN install2.r --error -- --clean \
    # data manipulation
    reshape2 \
    matrixStats \
    dplyr \
    tidyverse \
    stringr \
    # R Shiny
    shiny \
    # matrix decomposition
    umap \
    Rtsne \
    RGCCA \
    # graph
    igraph \
    dynamicTreeCut \
    # machine learning 
    fastcluster \
    AUC \
    caret \
    mlr3 \
    kernlab \
    randomForest \
    # visualisation
    factoextra \
    pheatmap \
    gplots \
    ggraph \
    plotly \
    VennDiagram \
    # xai
    iml \
    lime \
    shapr \
    # bioinfor
    gprofiler2


# install Bioconductor packages
RUN ln -s /usr/local/lib/R/site-library/littler/examples/installBioc.r /usr/local/bin/installBioc.r

RUN installBioc.r --error -- --clean \
    # RNA-Seq
    DESeq2 \
    GSEABase \
    limma \
    edgeR \
    sva \
    # multiomics
    mixOmics \
    omicade4 \
    MOFA2 \
    MOFAdata \
    # gcns
    WGCNA 


# install GitHub packages
RUN installGithub.r \
    isglobal-brge/rexposome \
    isglobal-brge/omicRexposome \
    karlkumbier/iRF2.0


# clean
RUN set -ex \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
