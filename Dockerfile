FROM runpod/pytorch:3.10-2.0.1-118-runtime

ENV TORCH_COMMAND="pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118"

WORKDIR /workspace

COPY webui/install-automatic.py .

RUN apt update --yes && \
apt upgrade --yes && \
apt install --yes --no-install-recommends \
  rsync \
  unzip \
  libgoogle-perftools4 \
  libtcmalloc-minimal4 \
  python3.10-venv && \
python -m pip install --upgrade pip && \
python -m venv /workspace/venv && \
  export PATH="/workspace/venv/bin:$PATH" && \
curl -L https://github.com/storj/storj/releases/download/v1.84.1/uplink_linux_amd64.zip -o uplink_linux_amd64.zip && \
  unzip -o uplink_linux_amd64.zip && \
  install uplink /usr/local/bin/uplink && \
  rm uplink_linux_amd64.zip && \
  rm uplink && \
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
  cd stable-diffusion-webui && \
  git checkout tags/v1.5.1 && \
  mv /workspace/install-automatic.py /workspace/stable-diffusion-webui/ && \
  python -m install-automatic --skip-torch-cuda-test && \
cd /workspace/stable-diffusion-webui && \
  git clone https://github.com/jtydhr88/sd-webui-StableStudio.git extensions/stablestudio && \
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh && \
  bash /tmp/nodesource_setup.sh && \
  apt install nodejs && \
  rm /tmp/nodesource_setup.sh && \
  npm install -g yarn && \
cd /workspace && \
  git clone https://github.com/Stability-AI/StableStudio.git && \
  cd StableStudio && \
  yarn && \
mkdir /dreambooth && \
  cd /dreambooth && \
  curl -L https://github.com/ShivamShrirao/diffusers/raw/main/examples/dreambooth/train_dreambooth.py -o train_dreambooth.py && \
  curl -L https://github.com/ShivamShrirao/diffusers/raw/main/scripts/convert_diffusers_to_original_stable_diffusion.py -o convert_diffusers_to_original_stable_diffusion.py && \
pip cache purge && \
apt clean && \
mv /workspace/venv /venv && \
mv /workspace/stable-diffusion-webui /stable-diffusion-webui && \
mv /workspace/StableStudio /StableStudio

COPY webui/* /stable-diffusion-webui/
COPY DreamBooth_Stable_Diffusion.ipynb /
COPY scripts/* /
RUN chmod a+x /*.sh

SHELL ["/bin/bash", "--login", "-c"]
CMD ["/start.sh"]
