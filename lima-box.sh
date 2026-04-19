#!/bin/bash

CALLER_DIR="$(pwd)"
ROOT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")
cd "${ROOT_DIR}"

## normal start
STATUS=$(limactl ls --format '{{.Status}}' ai-box 2>/dev/null || true)
if [ "${STATUS}" != "Running" ]; then
  limactl start ai-box
fi

## shell with --sync (syncs caller's working directory into the VM)
## after exiting, you'll be prompted to accept/reject changes
cd "${CALLER_DIR}"
limactl shell --sync . ai-box

## run an AI agent directly with --sync
# cd /path/to/project
# limactl shell --sync . ai-box claude "implement feature X"
# limactl shell --sync . ai-box kiro-cli
