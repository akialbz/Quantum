#
# Starlight JupyterLab
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:lab


# install additional Python packages
# -------------------------------------------------------------
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       # statistical & ML
       fitter \
       imbalanced-learn \
       scikit-optimize \
       LIME \
       SHAP \
       scikit-fuzzy \
       pymoo \
       mrmr_selection \
       umap-learn \
       mofapy2 \
       mofax \
       # visualisation
       seaborn \
       yellowbrick \
       bokeh \
       pyvis


# install additional R packages
# -------------------------------------------------------------
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       zlib1g \
       zlib1g-dev \
       libblas3 \
       libblas-dev \
       liblapack3 \
       liblapack-dev \
       libxml2 \
       libxml2-dev \
       libpng16-16 \
       libpng-dev \
       gfortran

RUN install2.r --error -- --clean \
    reshape \
    tidyverse \
    dplyr

RUN installBioc.r --error -- --clean \
    DESeq2 \
    limma \
    sva \
    mixOmics

RUN installGithub.r karlkumbier/iRF2.0

RUN apt-get purge -y \
    zlib1g-dev \
    libblas-dev \
    liblapack-dev \
    libxml2-dev \
    libpng-dev


# install additional kernels
# -------------------------------------------------------------
# lazypredict kernel
RUN set -ex \
    && conda create -n lazypredict python=3.9 -c conda-forge \
    && conda run --no-capture-output -n lazypredict \
       pip install --no-cache-dir hypothesis pytest requests tables kagami ipykernel \
    && conda run --no-capture-output -n lazypredict \
       pip install --no-cache-dir lazypredict \
    && conda run --no-capture-output -n lazypredict \
       python -m ipykernel install --user --name=LazyPredict \
    && conda clean --all --yes


# update JupyterLab extensions
# -------------------------------------------------------------
RUN set -ex \
    && apt-get install -y --no-install-recommends git \
    && install2.r --error -- --clean languageserver \
    && pip3 install --no-cache-dir \
    #    elyra-pipeline-editor-extension \
    #    elyra-code-snippet-extension \
       elyra-python-editor-extension \
       elyra-r-editor-extension \
    && jupyter lab build --name='Quantum Starlight' \
    && jupyter lab clean \
    && jlpm cache clean \
    && npm cache clean --force


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set entry
# -------------------------------------------------------------
ENV PASSWORD=""
EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=$PASSWORD"]
