#!/bin/bash

INSTANCE="ai-box"

[[ ! -f /Users/tabpema9/.lima/${INSTANCE}/lima.yaml ]] && { echo "Instance ${INSTANCE} does not exist. Nothing to delete."; exit 0; }

limactl stop "${INSTANCE}"
limactl delete "${INSTANCE}"