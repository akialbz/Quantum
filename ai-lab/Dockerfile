#
# JupyterLab app with Kagami and ACS frameworks and DL toolkits
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
       umap-learn \
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
    dplyr \
    umap \
    Rtsne \
    caret \
    mlr3 \
    gplots \
    plotly \
    igraph \
    dynamicTreeCut \
    AUC \
    doMC

RUN installBioc.r --error -- --clean \
    DESeq2 \
    limma \
    sva \
    mixOmics \
    MOFA2

RUN installGithub.r karlkumbier/iRF2.0

RUN apt-get purge -y \
    zlib1g-dev \
    libblas-dev \
    liblapack-dev \
    libxml2-dev \
    libpng-dev


# install additional kernels
# -------------------------------------------------------------
# Keras kernels
RUN set -ex \
    && conda create -n keras tensorflow keras python=3 \
    && conda run --no-capture-output -n keras \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras \
       python -m ipykernel install --user --name=Keras --display-name="Keras (CPU)" \
    && conda clean --all --yes

RUN set -ex \
    && conda create -n keras-gpu tensorflow-gpu keras python=3 \
    && conda run --no-capture-output -n keras-gpu \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras-gpu \
       python -m ipykernel install --user --name=Keras_GPU --display-name="Keras (GPU)" \
    && conda clean --all --yes

# PyTorch kernels
RUN set -ex \
    && conda create -n pytorch pytorch torchvision torchaudio cpuonly python=3 -c pytorch\
    && conda run --no-capture-output -n pytorch \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n pytorch \
       python -m ipykernel install --user --name=PyTorch --display-name="PyTorch (CPU)" \
    && conda clean --all --yes

RUN set -ex \
    && conda create -n pytorch-gpu pytorch torchvision torchaudio cudatoolkit=11.3 python=3 -c pytorch\
    && conda run --no-capture-output -n pytorch-gpu \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n pytorch-gpu \
       python -m ipykernel install --user --name=PyTorch_GPU --display-name="PyTorch (GPU)" \
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
    && jupyter lab build --name='Quantum AI Lab' \
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

