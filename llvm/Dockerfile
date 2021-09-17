FROM ubuntu:focal
LABEL MAINTAINER="Benjamin Flin"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
apt install -y git wget cmake make clang

RUN cd /tmp \
&& git clone https://github.com/llvm/llvm-project.git

RUN cd /tmp/llvm-project \
&& git checkout llvmorg-10.0.1 \
&& cmake -G 'Unix Makefiles' -B build -DLLVM_ENABLE_PROJECTS='clang;libclc;libcxx;libcxxabi;lld' -DCLANG_PYTHON_BINDINGS_VERSIONS='2.7;3.8' -DLLVM_TARGETS_TO_BUILD='X86' -DCMAKE_BUILD_TYPE=Debug llvm

RUN cd /tmp/llvm-project/build && make -j24

RUN cd /tmp/llvm-project/build && cpack --verbose -G TGZ

RUN mv /tmp/llvm-project/build/LLVM*.tar.gz /opt/