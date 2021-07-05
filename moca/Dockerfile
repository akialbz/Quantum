#
# Modified from official Python and R Dockerfiles for machine learning
# JupyterLab, RStudio, and MOCA packages included
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM quantum:lab

# Install additional Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       kagami \
       python-igraph \
       pyvis \
       scikit-fuzzy 

# Install R packages
RUN R -e 'install.packages(c( \
              "RGCCA", \
              "igraph", \
          ), repos = "http://cran.uk.r-project.org", ask = F, clean = T)'
