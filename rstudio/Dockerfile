#
# Modified from official R Dockerfiles
# RStudio included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:r

# add new user
COPY passwd /usr/local/
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && useradd -m -d /home/docker -U docker \
    && cat /usr/local/passwd | chpasswd \
    && adduser docker sudo \
    && addgroup docker staff \
    && rm /usr/local/passwd

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       wget \
       gdebi-core \
       build-essential

# install RStudio Server
RUN set -ex \
    && wget --no-check-certificate https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb \
    && gdebi -n rstudio-server-2021.09.0-351-amd64.deb \
    && rm rstudio-server-2021.09.0-351-amd64.deb \
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
       wget \
       gdebi-core \
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
