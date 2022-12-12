#
# JupyterLab app with Kagami and ACS frameworks
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:acs


# install conda
# -------------------------------------------------------------
RUN set -ex \
    && curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh \
    && bash miniconda.sh -bfp /usr/local/conda/ \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/conda \
    && rm -rf miniconda.sh \
    && conda config --set auto_activate_base false


# install JupyterLab
# -------------------------------------------------------------
# JupyterLab app
ENV NODE_OPTIONS="--max-old-space-size=4096" 
RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y --no-install-recommends nodejs 

RUN pip3 install --no-cache-dir jupyterlab jedi ipykernel

# Jupyter extensions
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
    && jupyter lab build --name='Quantum'\
    && jupyter lab clean \
    && jlpm cache clean \
    && npm cache clean --force

# R kernel
RUN set -ex \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt-get --purge autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set entry
# -------------------------------------------------------------
ENV PASSWORD=""
EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=$PASSWORD"]
