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
    && apt update \
    && apt install -y --no-install-recommends \
    cmake \
    python3-graph-tool

RUN set -ex \
    && pip3 install --no-cache-dir \
       # statistical & ML
       swig>=4.3.0 \
       oapackage>=2.7.14 \
       fitter \
       LIME \
       SHAP \
       imbalanced-learn \
       scikit-optimize \
       pingouin \
       pymoo \
       umap-learn \
       mofapy2 \
       mofax \
       gseapy \
       # visualisation
       seaborn \
       yellowbrick


# install additional R packages
# -------------------------------------------------------------
# RUN set -ex \
#     && apt update \
#     && apt install -y --no-install-recommends \
#        zlib1g-dev

RUN install2.r --error -- --clean \
    reshape \
    tidyverse \
    dplyr 


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


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt --purge autoremove -y \
    && apt autoclean -y \
    && apt clean -y \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set entry
# -------------------------------------------------------------
ENV PASSWORD=""
EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=$PASSWORD"]
