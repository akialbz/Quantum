#
# Modified from official Python and R Dockerfiles
# JupyterLab and RStudio included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:dev-r

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
    && curl -sL https://github.com/jgm/pandoc/releases/download/2.13/pandoc-2.13-linux-amd64.tar.gz | tar zxf - \
    && mv pandoc-2.13/bin/* /usr/local/bin/ \
    && mv pandoc-2.13/share/man/man1/* /usr/local/share/man/man1/ \
    && rm -rf pandoc-2.13

# Install RStudio Server
RUN set -ex \
    && apt-get install -y --no-install-recommends gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1106-amd64.deb \
    && gdebi -n rstudio-server-1.4.1106-amd64.deb \
    && rm rstudio-server-1.4.1106-amd64.deb \
    && echo 'lock-type=advisory' >> /etc/rstudio/file-locks \
    && echo 'rsession-which-r=/usr/bin/R \
           \nauth-none=1' >> /etc/rstudio/rserver.conf \
    && mkdir -p /home/docker/.rstudio/monitored/user-settings \
    && echo 'alwaysSaveHistory="0" \
           \nloadRData="0" \
           \nsaveAction="0"' > /home/docker/.rstudio/monitored/user-settings/user-settings \
    && chown -R docker:docker /home/docker/.rstudio

# Install JupyterLab
# node.js
ENV NODE_OPTIONS="--max-old-space-size=4096" 

RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y --no-install-recommends nodejs 

# jupyterlab & kernels
RUN set -ex \
    && pip3 install jupyterlab \
    && pip3 install --no-cache-dir \
       # newer version not yet compatible
       jedi==0.17.2 \
       ipykernel \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'

# extensions
RUN set -ex \
    && pip3 install --no-cache-dir \
       ipywidgets \
       ipympl \
       jupyter_bokeh \
       kaleido \
       chart-studio \
       jupyter-dash \
       lckr-jupyterlab-variableinspector \
       jupyter-resource-usage \
       jupyterlab-drawio \
       aquirdturtle_collapsible_headings \
    && jupyter labextension install \
       @jupyter-widgets/jupyterlab-manager \
       jupyter-matplotlib \
       jupyterlab-plotly \
       jupyterlab-chart-editor \
    && jupyter lab build --name='QuantumLab'\
    && jupyter lab clean \
    && jlpm cache clean \
    && npm cache clean --force

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
EXPOSE 8787 8888
ENV USER="docker"
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
