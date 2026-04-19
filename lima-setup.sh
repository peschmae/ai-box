#!/bin/bash
set -e

ROOT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")
cd "${ROOT_DIR}"

INSTANCE="ai-box"

# source AWS identity provider env vars if not already set
if [ -z "${AWS_IDENTITY_PROVIDER_URL:-}" ] && [ -f ~/.aws_identity_provider ]; then
  set -a
  . ~/.aws_identity_provider
  set +a
fi

# create only if instance doesn't exist
if ! limactl ls -q 2>/dev/null | grep -q "^${INSTANCE}$"; then
  echo "🔧 Creating ${INSTANCE} Lima instance..."
  limactl create --tty=false --name "${INSTANCE}" \
    --set ".env.AWS_IDENTITY_PROVIDER_URL = \"${AWS_IDENTITY_PROVIDER_URL}\"" \
    --set ".env.AWS_REGION = \"${AWS_REGION}\"" \
    ai-box.yaml
fi

# start only if not already running
STATUS=$(limactl ls --format '{{.Status}}' "${INSTANCE}" 2>/dev/null || true)
if [ "${STATUS}" != "Running" ]; then
  echo "🚀 Starting ${INSTANCE}..."
  limactl start "${INSTANCE}"
fi

echo "📦 Provisioning dotfiles..."
./lima-provision.sh

echo "✅ ${INSTANCE} is ready!"
echo ""
echo "Usage:"
echo "  cd /path/to/project"
echo "  limactl shell --sync . ${INSTANCE}"
