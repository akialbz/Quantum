#
# General docker image for algorithm development
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.9-slim-bullseye

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       libblas3 \
       libblas-dev \
       liblapack3 \
       liblapack-dev \
       libhdf5-dev \
       wget \
       locales \
       gnupg \
       build-essential

# install Python packages
RUN set -ex \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
       # base
       hypothesis \
       pytest \
       requests \
       pysocks \
       tables \
       # numeric
       numpy \
       scipy \
       pandas \
       bottleneck \
       # statistical & ML
       statsmodels \
       scikit-learn \
       # graph
       python-igraph \
       networkx \
       # visualisation
       matplotlib \
       plotly \
       # homebrew
       kagami

# install pandoc
ARG PANDOC_VERSION=2.18
RUN set -ex \
    && wget --no-check-certificate https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz \
    && tar -zxf pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz \
    && mv pandoc-${PANDOC_VERSION}/bin/* /usr/local/bin/ \
    && mkdir -p /usr/local/share/man/man1/ \
    && mv pandoc-${PANDOC_VERSION}/share/man/man1/* /usr/local/share/man/man1/ \
    && rm pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz \
    && rm -rf pandoc-${PANDOC_VERSION}

# install latest R
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN set -ex \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN set -ex \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' \
    && echo "deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t bullseye-cran40 -y --no-install-recommends \
       r-base \
       r-base-dev

# install rpy2
RUN pip3 install --no-cache-dir rpy2

# install R packages
RUN R -e 'install.packages(c( \
            "RGCCA" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

# clean
RUN set -ex \
    && apt-get purge -y \
       libhdf5-dev \
       libblas-dev \
       liblapack-dev \
       r-base-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set python lib dir
RUN set -ex \
    && mkdir -p /home/share/python/dist-packages/
ENV PYTHONPATH /home/share/python/dist-packages/

# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/
WORKDIR /home/docker/

# set entry
CMD bash
