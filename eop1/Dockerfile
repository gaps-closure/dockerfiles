FROM ubuntu:focal
MAINTAINER mkaplan@perspectalabs.com
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update                                   \
&&  apt-get -y install					\
    libapr1    						\
    libapr1-dev						\
    nasm						\
    yasm						\
    cmake						\
    autoconf						\
    automake						\
    libtool						\
    libssl-dev						\
    gcc							\
    make						\
    git							\
    libz3-dev						\
    libzmq3-dev						\
    libconfig-dev					\
    python3-pip						\
    wget						\
    libboost-all-dev 					\
    bc 							\
    openjdk-16-jre-headless				\
    libavcodec-dev 					\
    libavformat-dev 					\
    libswscale-dev					\
    net-tools						\
    vim

RUN pip3 install decorator==4.4.1 jsonschema==3.2.0 lark-parser==0.7.8 libconf==2.0.1 vstask==1.1.5

RUN cd /tmp \
&&  wget https://sourceforge.net/projects/gitslave/files/gitslave-2.0.2.tar.gz \
&& tar -xzvf gitslave-2.0.2.tar.gz \
&& cd gitslave-2.0.2 \
&& sed 's/pod2man/pod2man --name gits/' -i Makefile \
&& sed 's/pod2man/pod2man --name gits-checkup/' -i contrib/Makefile \
&& make \
&& make install \
&& cd /tmp; rm -rf gitslave-2.0.2*

RUN cd /tmp \
&& wget https://github.com/gaps-closure/build/releases/download/v1.2/LLVM-10.0.1-Linux.sh \
&& bash ./LLVM-10.0.1-Linux.sh --prefix=/usr/local --exclude-subdir \
&& rm LLVM-10.0.1-Linux.sh \
&& cp -r /usr/local/lib/python3.8/site-packages/clang /usr/local/lib/python3.8/dist-packages/clang

RUN cd /opt \
&& wget https://github.com/gaps-closure/build/releases/download/v1.2/closure_bin_v1.2_Ubuntu_20.04_x86_64.tar.gz \
&& tar -zxvf closure_bin_v1.2_Ubuntu_20.04_x86_64.tar.gz \
&& rm closure_bin_v1.2_Ubuntu_20.04_x86_64.tar.gz

RUN mkdir gaps \
&& cd gaps \
&& gits clone https://github.com/gaps-closure/build \
&& cd build/apps/eop1/scripts \
&& ./build_pinstall.sh

ARG HWMODE
RUN cd gaps \
&& cd build/apps/eop1/scripts \
&& ldconfig		      \
&& ./build_cases.sh -m $HWMODE

EXPOSE 21 22 6788 6789
