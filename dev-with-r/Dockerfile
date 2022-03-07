#
# General docker image for algorithm development with R and rpy2 support
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
       wget \
       locales \
       gnupg

# install pandoc
ARG PANDOC_VERSION=2.17.1.1
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

# install R packages
RUN R -e 'install.packages(c( \
            "dynamicTreeCut", \
            "RGCCA", \
            "igraph" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

# install rpy2
RUN pip3 install --no-cache-dir rpy2

# clean
RUN set -ex \
    && apt-get purge -y \
       libblas-dev \
       liblapack-dev \
       wget \
       r-base-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
