FROM closure:latest
MAINTAINER mkaplan@perspectalabs.com
ARG DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -y update                              \
&&  sudo apt-get -y install				\
    libapr1    						\
    libapr1-dev						\
    nasm						\
    yasm						\
    cmake						\
    autoconf						\
    automake						\
    libtool						\
    libssl-dev						\
    openjdk-14-jre-headless				\
    libavcodec-dev 					\
    libavformat-dev 					\
    libswscale-dev
    