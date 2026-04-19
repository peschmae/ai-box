#!/bin/bash

ROOT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")
cd "${ROOT_DIR}"

## normal start
#limactl start ai-box
#limactl shell ai-box

## suspend it
# exit
limactl stop ai-box
