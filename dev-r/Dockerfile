#
# Modified from official Python and R Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:dev

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libblas3 \
       libblas-dev \
       liblapack3 \
       liblapack-dev \
       locales \
       gnupg

# Install latest R
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN set -ex \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
    && echo "deb http://cloud.r-project.org/bin/linux/debian buster-cran40/" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t buster-cran40 -y --no-install-recommends \
       r-base \
       r-base-dev

# Install R packages
RUN R -e 'install.packages(c( \
             "dynamicTreeCut", \
             "RGCCA", \
             "igraph" \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'

# Install rpy2
RUN pip3 install --no-cache-dir rpy2

# clean
RUN set -ex \
    && apt-get purge -y \
       libblas-dev \
       liblapack-dev \
       r-base-dev \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*
        