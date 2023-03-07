#
# RStudio app with AI/ML toolkits
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM rocker/rstudio:latest


RUN apt-get update


# install R basis
RUN apt-get install -y --no-install-recommends \
    libpcre2-dev \
    libbz2-dev \
    zlib1g-dev \
    liblzma-dev \
    libicu-dev \
    libz-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libgit2-dev \
    libglpk-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    default-jre \
    default-jdk \
    cmake

RUN set -ex \
    && R CMD javareconf \
    && install2.r --error -- --clean rJava Rcpp


# install R installers
RUN ln -s /usr/local/lib/R/site-library/littler/examples/installBioc.r /usr/local/bin/installBioc.r
RUN install2.r --error -- --clean devtools BiocManager


# # install R packages
RUN install2.r --error -- --clean \
    # data manipulation
    reshape \
    tidyverse \
    dplyr \
    # R Shiny
    shiny \
    # matrix decomposition
    RGCCA \
    umap \
    Rtsne \
    # graph
    igraph \
    dynamicTreeCut \
    # machine learning 
    fastcluster \
    pvclust \
    caret \
    mlr3 \
    kernlab \
    randomForest \
    rpart \
    bartMachine \
    # visualisation
    factoextra \
    pheatmap \
    gplots \
    plotly \
    # iRF
    ranger \
    AUC \
    doMC \
    rgl \
    microbenchmark \
    profvis \
    # xai
    iml \
    lime

RUN installBioc.r --error -- --clean \
    # RNA-Seq
    DESeq2 \
    GSEABase \
    limma \
    sva \
    # multiomics
    mixOmics \
    omicade4 \
    MOFA2 \
    MOFAdata \
    # graph
    WGCNA \
    pkimes/sigclust2

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
