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

# Install verilator
cd verilator
autoconf
./configure --prefix /opt/verilator
make
sudo make install
echo 'export PATH=/opt/verilator/bin:$PATH' | sudo tee -a /etc/profile
cd ..

# Remove cloned repositories to save space in docker image
if [ "$DOCKER_BUILD" = true ]; then
  echo "Removing repositories"
  rm -r verilator
fi

echo "Done"