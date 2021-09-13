#
# Modified from official Python Dockerfiles
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM python:3.9-slim-bullseye

# Add new user
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends sudo \
    && useradd -m -d /home/docker -U docker \
    && echo "docker:passwd" | chpasswd \
    && adduser docker sudo \
    && addgroup docker staff

# Install Python packages
RUN set -ex \
    && pip3 install --upgrade --no-cache-dir pip \
    && pip3 install --no-cache-dir \
       numpy \
       scipy \
       hypothesis \
       pytest

# set work dirs
RUN set -ex \
    && mkdir -p /home/docker/project/ \
    && mkdir -p /home/docker/library/
ENV PYTHONPATH /home/docker/library/

# set entry
WORKDIR /home/docker/project/
CMD ["python3"]
