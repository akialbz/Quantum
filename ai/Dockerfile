#
# Docker image with JupyterLab for AI/ML
#
# author(s): Albert (aki) Zhou
# origin: 11-05-2018
#

FROM akialbz/quantum:acs

# install Keras kernels
RUN set -ex \
    && conda create -n keras tensorflow keras python=3 \
    && conda run --no-capture-output -n keras \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras \
       python -m ipykernel install --user --name=Keras --display-name="Keras (CPU)" \
    && conda clean --all --yes

RUN set -ex \
    && conda create -n keras-gpu tensorflow-gpu keras python=3 \
    && conda run --no-capture-output -n keras-gpu \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n keras-gpu \
       python -m ipykernel install --user --name=Keras_GPU --display-name="Keras (GPU)" \
    && conda clean --all --yes

# install PyTorch kernels
RUN set -ex \
    && conda create -n pytorch pytorch torchvision torchaudio cpuonly python=3 -c pytorch\
    && conda run --no-capture-output -n pytorch \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n pytorch \
       python -m ipykernel install --user --name=PyTorch --display-name="PyTorch (CPU)" \
    && conda clean --all --yes

RUN set -ex \
    && conda create -n pytorch-gpu pytorch torchvision torchaudio cudatoolkit=11.3 python=3 -c pytorch\
    && conda run --no-capture-output -n pytorch-gpu \
       pip install --no-cache-dir ipykernel \
    && conda run --no-capture-output -n pytorch-gpu \
       python -m ipykernel install --user --name=PyTorch_GPU --display-name="PyTorch (GPU)" \
    && conda clean --all --yes
