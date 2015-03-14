#!/usr/bin/env bash

BOX_NAME=CentOS6.6_custom

set -e

if [ -e ~/.vagrant.d/boxes/${BOX_NAME} ]; then
    rm -rf ~/.vagrant.d/boxes/${BOX_NAME}
    echo "boxes deleted"
fi

mkdir -p ../packer_box
mkdir -p ../packer_cache
export PACKER_CACHE_DIR="../packer_cache"

packer validate packer.json

packer build -only=virtualbox-iso packer.json

vagrant box add ${BOX_NAME} ../packer_box/${BOX_NAME}.box

