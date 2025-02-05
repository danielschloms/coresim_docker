FROM ubuntu:24.04

LABEL Name=etiss-24-04 Version=0.0.1

ARG REMOTE_USER

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
# && apt-get install -y apt-transport-https

# add-apt-repository
RUN apt-get install -y software-properties-common

# Go (ChipsAlliance riscv-vector-tests)
# RUN add-apt-repository ppa:longsleep/golang-backports
# RUN apt-get update
# RUN apt-get install --no-install-recommends -y golang-go 

# ETISS
RUN apt-get install --no-install-recommends -y \
    build-essential \
    git \
    cmake \
    libboost-system-dev \
    libboost-filesystem-dev \ 
    libboost-program-options-dev

# Spike
RUN apt-get install --no-install-recommends -y \
    device-tree-compiler \
    libboost-regex-dev \
    libboost-system-dev

# RISC-V GNU Toolchain
RUN apt-get install --no-install-recommends -y \
    autoconf \
    apt-utils \
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
    ssh \
    sudo \
    wget \
    vim \
    make \
    cmake \
    python3-venv \
    doxygen \
    gdb \
    bash-completion \
    clang-format \
    # Compilers
    gcc \
    gcc-multilib \
    g++ \
    g++-multilib 

ARG USERNAME=USERNAME
ARG USER_UID=1000
ARG USER_GID=1000

# Delete user if he exists
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME 
RUN apt-get update && apt-get upgrade -y
ENV SHELL=/bin/bash

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

# Enable mouse in tmux, escape time to 0 (vim/nvim)
RUN echo 'set -g mouse on' >> ~/.tmux.conf
RUN echo 'set -s escape-time 0' >> ~/.tmux.conf

# Export workspace paths
RUN echo 'export WS_PATH=$HOME/perfsim_workspace' >> ~/.bashrc
RUN echo "export RISCV=$HOME/perfsim_workspace/gnu64" >> /home/${USERNAME}/.bashrc
RUN echo 'export PATH=$RISCV/bin:$PATH' >> /home/${USERNAME}/.bashrc
RUN echo 'export VENV_NAME=venv64' >> /home/${USERNAME}/.bashrc
RUN echo 'export VENV_PATH=$WS_PATH/$VENV_NAME' >> /home/${USERNAME}/.bashrc

# Add script directory to PATH
RUN echo export 'PATH=$WS_PATH/ws_scripts:$PATH' >> /home/${USERNAME}/.bashrc

RUN echo 'alias odmp="riscv64-unknown-elf-objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data"'

# Change bash color in container
RUN echo 'export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;35m\]\\$\[\e[m\] "' >> ~/.bashrc
CMD ["/bin/bash"]
