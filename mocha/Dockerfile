#
# Starlight JupyterLab
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:lab-arm64


# install R and packages
# -------------------------------------------------------------
# install latest R
RUN set -ex \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends tzdata \
    && apt install -y --no-install-recommends \
       libcurl4-openssl-dev \
       libxml2-dev \
       libfontconfig1-dev \
       libharfbuzz-dev \
       libfribidi-dev \
       libfreetype6-dev \
       libpng-dev \
       libtiff5-dev \
       libjpeg-dev \
       libgit2-dev \
       libtirpc-dev \
       r-base \
       r-base-dev

# install rpy2
RUN pip3 install --no-cache-dir rpy2==3.5.16

# install littler
RUN R -e 'install.packages(c("littler","docopt"), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'
ENV PATH="/usr/local/lib/R/site-library/littler/bin:/usr/local/lib/R/site-library/littler/examples:${PATH}"

# install R basis
RUN apt install -y --no-install-recommends default-jre default-jdk

RUN set -ex \
    && R CMD javareconf \
    && install2.r --error -- --clean rJava Rcpp

# install R installers
RUN install2.r --error -- --clean devtools BiocManager

# install R packages
RUN set -ex \
    && install2.r --error -- --clean \
       RGCCA \
       dynamicTreeCut

# R kernel
RUN set -ex \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'


# install additional Python packages
# -------------------------------------------------------------
RUN set -ex \
    && pip3 install --no-cache-dir \
       # statistical & ML
       swig>=4.3.0 \
       oapackage>=2.7.14 \
       pymoo \
       mofapy2 \
       mofax \
       gseapy

RUN set -ex \
    && pip3 install --no-cache-dir torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cpu

RUN set -ex \
    && pip3 install --no-cache-dir torch_geometric

RUN set -ex \
    && apt install -y --no-install-recommends git cmake \
    && pip3 install --no-cache-dir --no-build-isolation git+https://github.com/pyg-team/pyg-lib.git \
    && pip3 install --no-cache-dir torch_scatter torch_sparse torch_cluster torch_spline_conv


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt --purge autoremove -y \
    && apt autoclean -y \
    && apt clean -y \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
