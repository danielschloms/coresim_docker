#!/bin/bash

docker build -t etiss-20_04 --build-arg USERNAME=$USER --build-arg USER_UID=$UID --build-arg USER_GID=$(id -g $USER) .