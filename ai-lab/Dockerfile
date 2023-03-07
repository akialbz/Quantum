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
       zlib1g-dev \
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
    cqn \
    DESeq2 \
    limma \
    sva \
    mixOmics \
    MOFA2

RUN installGithub.r karlkumbier/iRF2.0


# install additional kernels
# -------------------------------------------------------------
# Keras kernels
RUN set -ex \
    && conda create -n keras keras tensorflow python=3 \
    && conda run --no-capture-output -n keras \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras \
       python -m ipykernel install --user --name=Keras --display-name="Keras (CPU)" \
    && conda clean --all --yes

RUN set -ex \
    && conda create -n keras-gpu keras-gpu tensorflow-gpu python=3 \
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
    && conda create -n pytorch-gpu pytorch torchvision torchaudio pytorch-cuda=11.6 python=3 -c pytorch -c nvidia\
    && conda run --no-capture-output -n pytorch-gpu \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n pytorch-gpu \
       python -m ipykernel install --user --name=PyTorch_GPU --display-name="PyTorch (GPU)" \
    && conda clean --all --yes


# update JupyterLab extensions
# -------------------------------------------------------------
RUN set -ex \
    && apt-get install -y --no-install-recommends git \
    # && install2.r --error -- --clean languageserver \
    && pip3 install --no-cache-dir \
       jupyterlab-git \
       neptune-notebooks \
       jupyterlab-material-night-eighties \
       jupyterlab-horizon-theme \
       theme-darcula \
    #    elyra-pipeline-editor-extension \
    #    elyra-code-snippet-extension \
    #    elyra-python-editor-extension \
    #    elyra-r-editor-extension \
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

