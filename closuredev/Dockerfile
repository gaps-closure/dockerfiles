FROM ubuntu:focal
LABEL MAINTAINER="Benjamin Flin"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update           \
&&  apt-get -y install			\
	gcc							\
	make						\
	git							\
	libz3-dev					\
	libzmq3-dev					\
	libconfig-dev				\
	python3-pip					\
	wget						\
	libboost-all-dev 			\
	bc 							\
	xdot						\
	sudo						\
	jq							\
	z3							\
	python3-z3					\
	firefox                     \
	cmake                       \
    libtinfo-dev                \
    libxml2-dev                 

RUN python3 -m pip install		\
	decorator==4.4.1			\
	jsonschema==3.2.0			\
	lark-parser==0.7.8			\
	libconf==2.0.1				\
	vstask==1.1.5				\
	networkx==2.5 				\ 
	pydot==1.4.1				\
	genson==1.2.2				\
	dash==1.18.1				\
	dash-cytoscape==0.2.0		\
	pandas==1.2.1				\
	pyzmq==22.2.1



RUN cd /tmp \
&& wget https://sourceforge.net/projects/gitslave/files/gitslave-2.0.2.tar.gz \
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
&& cp -r /usr/local/lib/python3.8/site-packages/clang /usr/local/lib/python3.8/dist-packages/clan




RUN useradd -ms /bin/bash closure \
&& usermod -aG sudo closure \
&& echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get -y update \
&&  apt-get -y install \ 
    bridge-utils \
    ebtables \
    iproute2 \
    xterm \
    mgen \
    traceroute \
    ethtool \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    libev-dev \
    python3-venv \
    tcl \
    tcl8.6 \
    tk \
    tk8.6 \
    libtk-img \
    quagga \
    uml-utilities \
    net-tools \
    ubuntu-dev-tools \
    qemu \
    qemu-efi \
    qemu-user-static \
    qemu-system-arm \
    qemu-system-x86 \
    qemu-user \
    netcat \
    python3-tk \
    iputils-ping \
    tcpdump

RUN python3 -m pip install \
    grpcio==1.27.2 \	
    grpcio-tools==1.27.2 \
    lxml==4.6.2 \
    protobuf==3.9.1 \
    six==1.14.0 \
    netaddr==0.8.0 \
    fabric==2.6.0 \
    Mako==1.1.4 \
    pyproj==3.0.0.post1 \
    pexpect==4.8.0

RUN cd /tmp \
&&  wget "https://github.com/coreemu/core/releases/download/release-6.5.0/core_6.5.0_amd64.deb" \
&&  dpkg -i core_6.5.0_amd64.deb \
&&  rm core_6.5.0_amd64.deb \
&&  cp -R /usr/local/lib/python3.6/dist-packages/core /usr/local/lib/python3.8/dist-packages/ 

COPY --from=llvm /opt/LLVM*.tar.gz /tmp/

RUN cd /tmp \
&& tar -xvzf LLVM-10.0.1-Linux.tar.gz \
&& mkdir -p /opt/closure/devel \
&& mv LLVM-10.0.1-Linux /opt/closure/devel/10.0.1dbg


RUN cd ~ \ 
&& mkdir gaps && cd gaps \
&& git clone https://github.com/gaps-closure/build.git \
&& cd build \
&& gits populate \ 
&& git checkout build-fixes \
&& ./build.sh \
&& scripts/install_closure.sh; exit 0 

RUN cd /opt/ \
&&  sudo mkdir minizinc \
&&  sudo wget https://github.com/MiniZinc/MiniZincIDE/releases/download/2.5.5/MiniZincIDE-2.5.5-bundle-linux-x86_64.tgz \
&&  sudo tar -xvzf MiniZinc* -C minizinc --strip-components=1

USER closure
ENV HOME /home/closure
ENV PATH=$PATH:/opt/minizinc/bin:$PATH
EXPOSE 21 22 6788 6789
