#!/bin/bash

if [ -f /.dockerenv ]; then
    DOCKER_BUILD=true
else
    DOCKER_BUILD=false
fi

# Repos
git clone https://github.com/PhilippvK/etiss --branch rvv-2024
git clone https://github.com/PhilippvK/etiss_arch_riscv --branch rvv-2024 --recursive
git clone https://github.com/tum-ei-eda/etiss_riscv_tests.git --branch rvv-2024
git clone https://github.com/PhilippvK/M2-ISA-R --branch rvv-2024
git clone https://github.com/PhilippvK/riscv-tests --branch rvv_tests --recursive
git clone https://github.com/tum-ei-eda/softvector --branch rvv1.0
git clone https://github.com/PhilippvK/rvv-cdsl2-gen --branch main

# Setup venv
virtualenv -p python3.8 venv
source venv/bin/activate
pip install -r etiss_riscv_tests/requirements.txt
pip install -r rvv-cdsl2-gen/requirements.txt

# Setup M2-ISA-R
pip install -e M2-ISA-R

# Setup ETISS
mkdir -p etiss/build
cd etiss/build
cmake -DCMAKE_INSTALL_PREFIX=$(pwd)/install/ -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc)
make install
cd -

# Download RISC-V Toolchain
mkdir -p gnu
cd gnu
wget https://syncandshare.lrz.de/dl/fiWBtDLWz17RBc1Yd4VDW7/GCC/default/2023.11.27/Ubuntu/20.04/rv32gcv_ilp32d.tar.xz
tar xvf rv32gcv_ilp32d.tar.xz
rm rv32gcv_ilp32d.tar.xz
cd -
# Do not forget to export these in every terminal session!
export RISCV=$(pwd)/gnu
export PATH=$RISCV/bin:$PATH

# Setup RISC-V Tests
cd riscv-tests
autoconf
./configure --prefix=$RISCV/target
make -j1 -C isa XLEN=32
cd -

echo "Done"