#
# Docker image with JupyterLab for AI/ML
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:lab

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
       libjpeg62-turbo \
       libjpeg62-turbo-dev \
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
       libopenmpi-dev

# install R packages
RUN R CMD javareconf
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

# install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       mpi4py \
       numba \
       mpmath \
       numexpr \
       imbalanced-learn \
       mvlearn \
       MKLpy \
       pyrcca \
       LIME \
       SHAP \
       pyvis \
       Yellowbrick

# install lazypredict kernel
RUN set -ex \
    && conda create -n lazypredict python=3.9 -c conda-forge \
    && conda run --no-capture-output -n lazypredict \
       pip install --no-cache-dir hypothesis pytest requests tables kagami ipykernel \
    && conda run --no-capture-output -n lazypredict \
       pip install --no-cache-dir lazypredict \
    && conda run --no-capture-output -n lazypredict \
       python -m ipykernel install --user --name=LazyPredict \
    && conda clean --all --yes

# install Keras kernel
RUN set -ex \
    && conda create -n keras pytorch torchvision torchaudio cpuonly tensorflow keras h5py python=3 -c pytorch \
    && conda run --no-capture-output -n keras \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras \
       python -m ipykernel install --user --name=Keras \
    && conda clean --all --yes

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
       libjpeg62-turbo-dev \
       libunwind-dev \
       libfreetype6-dev \
       zlib1g-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
