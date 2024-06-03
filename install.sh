#!/bin/bash

if [ -f /.dockerenv ]; then
    DOCKER_BUILD=true
else
    DOCKER_BUILD=false
fi

PARAM_FILE="libraries.txt"

while IFS=, read -r name reference repo_url; do
  echo "Cloning $name at reference $reference from $repo_url"
  git clone "$repo_url"
  cd "$name"
  git checkout -q "$reference"
  cd ..
done < "$PARAM_FILE"

# Install ETISS
# Ref: bd49a5beb2d01a31b2e7fe2ea8ba594a8c1d8835 
# -> Latest master commit, 06.03.2024
cd etiss
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/etiss
make -j4
make install
cd ..

# Install Verilator
# Ref: 522bead374d6b7b2adb316304126e5361b18bcf1 
# -> v5.024
cd verilator
autoconf
./configure --prefix /opt/verilator
make
sudo make install
echo 'export PATH=/opt/verilator/bin:$PATH' | sudo tee -a /etc/profile
cd ..

# Install RISC-V GNU Toolchain
# Ref: f133b299b95065aaaf040e18b578fea6bbef532e
# -> Nightly: April 12, 2024
install_riscv_gcc(){
  if [[ $# -ne 2 ]]; then
    echo "Error: RISCV GCC needs architecture and ABI"
    exit 1
  fi
  echo "Arch: $1, ABI: $2"
  ./configure --prefix=/opt/riscv-gnu-toolchain/$1 --with-arch=$1 --with-abi=$2
  make
}
cd riscv-gnu-toolchain
  install_riscv_gcc rv32im ilp32
  install_riscv_gcc rv32imf ilp32f
  install_riscv_gcc rv32imzve32x ilp32
  install_riscv_gcc rv32imfzve32x ilp32f
cd ..

# Remove cloned repositories to save space in docker image
if [ "$DOCKER_BUILD" = true ]; then
  echo "Removing repositories"
  rm -r etiss
  rm -r verilator
  rm -r riscv-gnu-toolchain
fi

echo "Done"