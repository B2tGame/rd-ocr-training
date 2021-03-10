ARG UBUNTU_VERSION=18.04
ARG DOCKER_VERSION=1.0.1

FROM ubuntu:${UBUNTU_VERSION} as base

ENV MODEL_NAME = new_model
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8



RUN apt-get update && \
	apt-get install -y \
  curl git unzip automake libtool software-properties-common build-essential wget bc \
  pkg-config libpng-dev libjpeg8-dev libtiff5-dev zlib1g-dev libicu-dev libpango1.0-dev libcairo2-dev

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    git \
    locales \
    python3-pip \
    libsm6 \
    libfontconfig1 \
    libxrender1 \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libxext6 \
    libraqm-dev \
    virtualenv \
    libgl1-mesa-glx \
 && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Clone git repo
RUN mkdir /app /app/code  && \      
           cd /app/code && \        
           git clone https://github.com/tesseract-ocr/tesstrain.git

# Copy entrypoint script
COPY commands.sh /app/code/commands.sh
RUN ["chmod", "+x", "/app/code/commands.sh"]

# Set working directory
WORKDIR /app/code/tesstrain

RUN mkdir  /app/code/tesstrain/data/ /app/code/tesstrain/data/new_model && \
mkdir /app/code/tesstrain/data/new_model-ground-truth

# Install and compile Tesseract
RUN make leptonica tesseract

RUN virtualenv --python python3 /env
ENV PATH="/env/bin:$PATH"

# Install python dependencies 
RUN /env/bin/pip install --upgrade pip
RUN /env/bin/pip install -r requirements.txt
RUN /env/bin/pip uninstall -y Pillow
# Get training data to
COPY /datasetGenerator /app/code/trdg
WORKDIR /app/code/trdg

RUN /env/bin/pip install codecov
RUN /env/bin/pip install --upgrade setuptools

RUN git clone https://github.com/python-pillow/Pillow.git \
 && cd Pillow \
 && git checkout 7.0.x \
 && /env/bin/python setup.py build_ext --enable-freetype install && \
 /env/bin/python setup.py install 

RUN /env/bin/pip install -r requirements.txt
RUN /env/bin/pip install pytest

# WORKDIR /app/code/tesstrain

ENTRYPOINT [ "/app/code/commands.sh" ]

# start training
# RUN make training MODEL_NAME=new_model

# RUN make training MODEL_NAME = MODEL_NAME
