#
# Kagami and ACS frameworks for algorithm development
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:kagami-arm64


# install additional Python packages
# -------------------------------------------------------------
RUN set -ex \
    && pip3 install --no-cache-dir \
       # statistical & ML
       statsmodels \
       scikit-learn \
       # graph
       python-igraph \
       networkx \
       # visualisation
       matplotlib \
       plotly
       # homebrew
      #  acs


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
       r-base \
       r-base-dev

# install rpy2
RUN pip3 install --no-cache-dir rpy2

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
    && install2.r --error -- --clean RGCCA igraph dynamicTreeCut fastcluster \
    && installBioc.r --error -- --clean WGCNA


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt --purge autoremove -y \
    && apt autoclean -y \
    && apt clean -y \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
