#
# Docker image with JupyterLab
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:dev-with-r

# install dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \ 
       libzmq5 \
       libzmq5-dev \
       libunwind8 \
       libunwind-dev \
       curl

# install JupyterLab
# node.js
ENV NODE_OPTIONS="--max-old-space-size=4096" 

RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y --no-install-recommends nodejs 

# jupyterlab & kernels
RUN set -ex \
    && pip3 install --no-cache-dir jupyterlab \
    && pip3 install --no-cache-dir \
       jedi \
       ipykernel \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'

# python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       virtualenv \
       matplotlib \
       seaborn \
       plotly \
       bokeh

# extensions
RUN set -ex \
    && pip3 install --no-cache-dir \
       ipywidgets \
       ipympl \
       jupyter_bokeh \
       kaleido \
       chart-studio \
       jupyter-dash \
       jupyter-resource-usage \
       jupyterlab-drawio \
    && jupyter labextension install \
       @jupyter-widgets/jupyterlab-manager \
       jupyter-matplotlib \
       jupyterlab-plotly \
       jupyterlab-chart-editor \
    && jupyter lab build --name='QuantumLab'\
    && jupyter lab clean \
    && jlpm cache clean \
    && npm cache clean --force

# config Jupyter
COPY passwdcfg /usr/local/
RUN set -ex \
    && jupyter notebook --generate-config \
    && cat /usr/local/passwdcfg >> /root/.jupyter/jupyter_server_config.json \
    && rm /usr/local/passwdcfg

# install conda
RUN set -ex \
    && curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -bfp /usr/local/conda/ \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/conda \
    && rm -rf miniconda.sh \
    && conda config --set auto_activate_base false

# clean
RUN set -ex \
    && apt-get purge -y \
       libzmq5-dev \
       libunwind-dev \
       curl \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# set lib dirs
RUN set -ex \
    && mkdir -p /home/share/python/dist-packages/
ENV PYTHONPATH /home/share/python/dist-packages/

# set entry
EXPOSE 8888
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
