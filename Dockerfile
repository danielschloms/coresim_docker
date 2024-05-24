FROM ubuntu:24.04

LABEL Name=coresim-docker Version=0.0.1

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends -y \
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
        llvm-17 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install libraries
COPY install.sh /install.sh
COPY libraries.txt /libraries.txt
RUN chmod +x /install.sh && ./install.sh

ENTRYPOINT [ "/bin/bash" ]
