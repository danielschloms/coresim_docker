#!/bin/bash

if [ $1 = "etiss20" ]; then
  echo "Building Ubuntu 20.04 version"
  cd ubuntu20_04
  docker build -t etiss-20_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

if [ $1 = "etiss24" ]; then
  echo "Building Ubuntu 24.04 version for ETISS"
  cd ubuntu24_04
  docker build -t etiss-24_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

if [ $1 = "ml22" ]; then
  echo "Building Ubuntu 22.04 version for ML on MCU"
  cd mlonmcu
  docker build -t mlonmcu-22_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

if [ $1 = "perfsim24" ]; then
  echo "Building Ubuntu 24.04 version for performance estimator"
  cd perfsim
  docker build -t perfsim-24_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

echo "Specify build"
echo "  - etiss20"
echo "  - etiss24"
echo "  - ml22"
echo "  - perfsim24"