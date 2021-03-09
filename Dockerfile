ARG UBUNTU_VERSION=18.04
ARG DOCKER_VERSION=1.0.1

FROM ubuntu:${UBUNTU_VERSION} as base

ENV MODEL_NAME = new_model


RUN apt-get update && \
	apt-get install -y \
  curl git unzip automake libtool software-properties-common build-essential wget \
  pkg-config libpng-dev libjpeg8-dev libtiff5-dev zlib1g-dev libicu-dev libpango1.0-dev libcairo2-dev

RUN apt-get update && \
	apt-get install -y python3-pip

# Clone git repo
RUN mkdir /home/app && \      
           cd /home/app && \        
           git clone https://github.com/tesseract-ocr/tesstrain.git

# Set working directory
WORKDIR /home/app/tesstrain

RUN mkdir  /home/app/tesstrain/data /home/app/tesstrain/data/new_model && \
mkdir /home/app/tesstrain/data/new_model-ground-truth

# Install and compile Tesseract
RUN make leptonica tesseract

# Install python dependencies
RUN pip3 install -r requirements.txt

# Get training data to

# start training
RUN make training MODEL_NAME=new_model

# RUN make training MODEL_NAME = MODEL_NAME
