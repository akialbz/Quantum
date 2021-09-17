#
# Modified from official R Dockerfiles
# RStudio included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:r

# Install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libzmq5 \
       libzmq5-dev \
       libunwind8 \
       libunwind-dev \
       libfreetype6 \
       libfreetype6-dev \
       curl \
       wget \
       build-essential

RUN set -ex \
    && curl -sL https://github.com/jgm/pandoc/releases/download/2.14.2/pandoc-2.14.2-linux-amd64.tar.gz | tar zxf - \
    && mv pandoc-2.14.2/bin/* /usr/local/bin/ \
    && mkdir -p /usr/local/share/man/man1/ \
    && mv pandoc-2.14.2/share/man/man1/* /usr/local/share/man/man1/ \
    && rm -rf pandoc-2.14.2

# Install RStudio Server
RUN set -ex \
    && apt-get install -y --no-install-recommends gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb \
    && gdebi -n rstudio-server-1.4.1717-amd64.deb \
    && rm rstudio-server-1.4.1717-amd64.deb \
    && echo 'lock-type=advisory' >> /etc/rstudio/file-locks \
    && echo 'rsession-which-r=/usr/bin/R' >> /etc/rstudio/rserver.conf \
    && mkdir -p /home/docker/.rstudio/monitored/user-settings \
    && echo 'alwaysSaveHistory="0" \
           \nloadRData="0" \
           \nsaveAction="0"' > /home/docker/.rstudio/monitored/user-settings/user-settings \
    && chown -R docker:docker /home/docker/.rstudio

# clean
RUN set -ex \
    && apt-get purge -y \
       libzmq5-dev \
       libunwind-dev \
       libfreetype6-dev \
       curl \
       wget \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set entry
EXPOSE 8787
ENV USER="docker"
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
