FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV HF_ENDPOINT=https://hf-mirror.com

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    python3.12 python3.12-venv python3.12-dev python3-pip \
    git wget curl ca-certificates \
    libsndfile1 ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

WORKDIR /app
COPY . /app

RUN pip install --upgrade pip setuptools wheel \
    && pip install .

CMD ["/bin/bash"]
