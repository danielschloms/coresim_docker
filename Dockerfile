FROM ubuntu:24.04

LABEL Name=coresim Version=0.0.1

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends -y \
        # riscv-gnu-toolchain (without packages already used for verilator/general packages)
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
        texinfo \
        gperf \
        libtool \
        patchutils \
        bc \
        libexpat-dev \
        ninja-build \
        libglib2.0-dev \
        libslirp-dev \
        # Verilator
        autoconf \
        bc \
        bison \
        build-essential \
        ca-certificates \
        ccache \
        flex \
        git \
        help2man \
        libfl2 \
        libfl-dev \
        libgoogle-perftools-dev \
        numactl \
        perl \
        perl-doc \
        python3 \
        zlib1g \
        zlib1g-dev \
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
        srecord \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install libraries
COPY install.sh /install.sh
COPY libraries.txt /libraries.txt
RUN chmod +x /install.sh && ./install.sh

ENTRYPOINT [ "/bin/bash" ]
