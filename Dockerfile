FROM ubuntu:24.04

LABEL Name=etiss Version=0.0.1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive

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
    # Compilers
    gcc \
    gcc-multilib \
    g++ \
    g++-multilib \
    llvm-18 \
    clang-18 \
    # Needed by clang-18
    lld \
    # Needed by Vicuna
    srecord

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install libraries
# COPY install.sh /install.sh
# COPY libraries.txt /libraries.txt
# RUN chmod +x /install.sh && ./install.sh

ENTRYPOINT [ "/bin/bash" ]
