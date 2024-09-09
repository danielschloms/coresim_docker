#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Error: missing arguments. Usage: $0 user uid gid"
  exit 1
fi

groupadd --gid $3 $1
useradd --uid $2 --gid $3 --create-home $1