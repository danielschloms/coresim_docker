#!/bin/bash

if [ $1 = "20" ]; then
  echo "Building Ubuntu 20.04 version"
  cd ubuntu20_04
  docker build -t etiss-20_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

if [ $1 = "22" ]; then
  echo "Building Ubuntu 22.04 version"
  cd ubuntu22_04
  docker build -t etiss-22_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .
  exit 0
fi

echo "Specify Ubuntu version (20 or 22)"