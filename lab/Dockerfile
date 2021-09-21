#
# Modified from official Python and R Dockerfiles
# JupyterLab included
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
       curl \
       build-essential

# Install venv
RUN set -ex \
    && pip3 install virtualenv

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
       jedi \
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
    #    lckr-jupyterlab-variableinspector \
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
       curl \
       build-essential \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# config Jupyter
COPY passwdcfg /usr/local/
RUN set -ex \
    && jupyter notebook --generate-config \
    && cat /usr/local/passwdcfg >> /root/.jupyter/jupyter_server_config.json \
    && rm /usr/local/passwdcfg

# set entry
EXPOSE 8888
ENV USER="docker"
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
