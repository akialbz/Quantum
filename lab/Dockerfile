#
# JupyterLab app with Kagami and ACS frameworks
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#


FROM akialbz/quantum:acs-arm64


# install conda
# -------------------------------------------------------------
RUN set -ex \
    && curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -o miniconda.sh \
    && bash miniconda.sh -bfp /usr/local/conda/ \
    && ln -s /usr/local/conda/bin/conda /usr/local/bin/conda \
    && rm -rf miniconda.sh \
    && conda config --set auto_activate_base false


# install JupyterLab
# -------------------------------------------------------------
# JupyterLab app
ENV NODE_OPTIONS="--max-old-space-size=4096" 
RUN set -ex \
    && curl -fsSL https://deb.nodesource.com/setup_21.x | bash - \
    && apt install -y nodejs

RUN pip3 install --no-cache-dir jupyterlab jedi ipykernel

# Jupyter extensions
RUN set -ex \
    && pip3 install --no-cache-dir \
       ipywidgets \
       ipympl \
       anywidget \
       dash \
       kaleido \
       plotly-geo \
       voila \
       jupyter-resource-usage \
       jupyterlab-spreadsheet-editor 
       
RUN set -ex \
    && jupyter lab build --name='Quantum' \
    && jupyter lab clean \
    && npm cache clean --force

# R kernel
RUN set -ex \
    && R -e 'install.packages("IRkernel", repos="https://cloud.r-project.org/"); IRkernel::installspec()'


# clean apt
# -------------------------------------------------------------
RUN set -ex \
    && apt --purge autoremove -y \
    && apt autoclean -y \
    && apt clean -y \
    && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*


# set entry
# -------------------------------------------------------------
ENV PASSWORD=""
EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter lab --ip=0.0.0.0 --allow-root --no-browser --ServerApp.token=$PASSWORD"]
