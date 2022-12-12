#
# Kagami and ACS frameworks for algorithm development
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:kagami


# install additional Python packages
# -------------------------------------------------------------
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
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
    && apt-get update \
    && apt-get install -y --no-install-recommends gnupg 

RUN set -ex \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' \
    && echo "deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t bullseye-cran40 -y --no-install-recommends \
       r-base \
       r-base-dev

# install rpy2
RUN pip3 install --no-cache-dir rpy2==3.4.5

# install littler
RUN R -e 'install.packages(c("littler","docopt"), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'
ENV PATH="/usr/local/lib/R/site-library/littler/bin:/usr/local/lib/R/site-library/littler/examples:${PATH}"

# install R basis
RUN apt-get install -y --no-install-recommends \
    default-jre \
    default-jdk

RUN set -ex \
    && R CMD javareconf \
    && install2.r --error -- --clean rJava Rcpp

# install R installers
RUN apt-get install -y --no-install-recommends \
    libcurl4 \
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libssl1.1 \
    libssl-dev \
    libfontconfig1 \
    libfontconfig-dev \
    libharfbuzz0b \
    libharfbuzz-dev \
    libfribidi0 \
    libfribidi-dev \
    libfreetype6 \
    libfreetype6-dev \
    libpng16-16 \
    libpng-dev \
    libtiff5 \
    libtiff5-dev \
    libjpeg62-turbo \
    libjpeg-dev \
    curl

RUN install2.r --error -- --clean devtools BiocManager

# install R packages
RUN set -ex \
    && install2.r --error -- --clean RGCCA igraph dynamicTreeCut fastcluster pvclust \
    && installBioc.r --error -- --clean WGCNA pkimes/sigclust2

# clean
RUN apt-get purge -y \
    r-base-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libfontconfig-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
