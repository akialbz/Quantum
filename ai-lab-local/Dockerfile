#
# Docker image with JupyterLab for AI/ML
# No auth, local usage only
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:ai-lab

RUN set -ex \
    && rm /root/.jupyter/jupyter_server_config.json \
    && rm /usr/local/bin/entrypoint.sh

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--LabApp.token=''"]

