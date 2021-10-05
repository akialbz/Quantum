#
# General docker image for algorithm development
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:base-with-r

# Install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       fastcluster \
       statsmodels \
       seaborn \
       scikit-learn \
       imbalanced-learn \
       scikit-fuzzy \
       python-igraph \
       networkx \
       matplotlib \
       plotly \
       pyvis
