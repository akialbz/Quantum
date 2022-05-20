#
# Docker image ACS
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:dev

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
       libzmq5 \
       libzmq5-dev \
       libjpeg62-turbo \
       libjpeg62-turbo-dev \
       libunwind8 \
       libunwind-dev \
       libfreetype6 \
       libfreetype6-dev \
       zlib1g \
       zlib1g-dev \
       gfortran \
       git \
       curl \
       pkg-config \
       default-jre \
       default-jdk 

# install JupyterLab
ENV NODE_OPTIONS="--max-old-space-size=4096" 
RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y --no-install-recommends nodejs 

RUN set -ex \
    && pip3 install --no-cache-dir jupyterlab jedi ipykernel

# Jupyter extensions
RUN set -ex \
    && pip3 install --no-cache-dir \
       ipywidgets \
       ipympl \
       jupyter_bokeh \
       kaleido \
       chart-studio \
       jupyter-dash \
       jupyter-resource-usage \
       jupyterlab-drawio \
    && jupyter labextension install \
       @jupyter-widgets/jupyterlab-manager \
       jupyter-matplotlib \
       jupyterlab-plotly \
       jupyterlab-chart-editor \
    && jupyter lab build --name='Quantum ACS'\
    && jupyter lab clean \
    && jlpm cache clean \
    && npm cache clean --force

# install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       # ML
       imbalanced-learn \
       pyrcca \
       LIME \
       SHAP \
       scikit-fuzzy \
       pymoo \
    && pip3 install --no-cache-dir \
       # statistical
       fitter \
       pandas-profiling \
    && pip3 install --no-cache-dir \
       # visualisation
       seaborn \
       bokeh \
       pyvis \
       yellowbrick

# install R packages
RUN R CMD javareconf
RUN R -e 'install.packages(c( \
            # utils
            "devtools", \
            "rJava", \
            "shiny" \
         ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)' 

RUN R -e 'install.packages(c( \
            # data manipulation
            "reshape", \
            "tidyverse", \
            "dplyr", \
            # matrix decomposition
            "umap", \
            "Rtsne", \
            # machine learning 
            "caret", \
            "mlr3", \
            # visualisation
            "gplots", \
            "plotly", \
            # graph
            "igraph", \
            "dynamicTreeCut", \
            # iRF
            "AUC", \
            "doMC" \
         ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

RUN R -e 'install.packages("BiocManager"); \
          BiocManager::install(c( \
            # RNA-Seq
            "DESeq2", \
            "limma", \
            "sva", \
            # multiomics
            "mixOmics", \
            "MOFA2", \
            # graph
            "WGCNA" \
          ), suppressUpdates = F, ask = F, clean = T)'

RUN R -e 'devtools::install_github("karlkumbier/iRF2.0")'

# install R kernel
RUN set -ex \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'

# install conda
RUN set -ex \
    && curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -bfp /usr/local/conda/ \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/conda \
    && rm -rf miniconda.sh \
    && conda config --set auto_activate_base false

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
       libzmq5-dev \
       libjpeg62-turbo-dev \
       libunwind-dev \
       libfreetype6-dev \
       zlib1g-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set entry
ENV PASSWORD=""
EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=$PASSWORD"]
