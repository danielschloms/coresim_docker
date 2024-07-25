FROM ubuntu:20.04

LABEL Name=etiss-20-04 Version=0.0.1

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# ETISS
RUN apt-get install --no-install-recommends -y \
    build-essential \
    git \
    cmake \
    libboost-system-dev \
    libboost-filesystem-dev \ 
    libboost-program-options-dev

# Verilator
RUN apt-get install --no-install-recommends -y \
    autoconf \
    bc \
    bison \
    build-essential \
    ca-certificates \
    ccache \
    flex \
    git \
    g++ \
    help2man \
    libfl2 \
    libfl-dev \
    libgoogle-perftools-dev \
    make \
    numactl \
    perl \
    perl-doc \
    python3 \
    zlib1g \
    zlib1g-dev 

# RISC-V GNU Toolchain
RUN apt-get install --no-install-recommends -y \
    autoconf \
    automake \
    autotools-dev \
    curl \
    python3 \
    python3-pip \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    gawk \
    build-essential \
    bison \
    flex \
    texinfo \
    gperf \
    libtool \
    patchutils \
    bc \
    zlib1g-dev \
    libexpat-dev \
    ninja-build \
    git \
    cmake \
    libglib2.0-dev \
    libslirp-dev

# Other packages
RUN apt-get install --no-install-recommends -y \
    # General packages
    sudo \
    wget \
    vim \
    make \
    cmake \
    python3-venv \
    doxygen \
    # Compilers
    gcc \
    gcc-multilib \
    g++ \
    g++-multilib \
    llvm-11 \
    clang-11 \
    # Needed by clang-18
    lld \
    # Needed by Vicuna
    srecord

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "export RISCV=/workspaces/etiss_workspace/gnu" >> /root/.bashrc
RUN echo 'export PATH=$RISCV/bin:$PATH' >> /root/.bashrc
RUN echo "export WS_PATH=/workspaces/etiss_workspace" >> /root/.bashrc
RUN echo "alias cdd='cd $WS_PATH'"

ENTRYPOINT [ "/bin/bash" ]
