#!/bin/bash

ROOT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")
cd "${ROOT_DIR}"

INSTANCE="ai-box"
GUEST_USER="$(limactl shell "${INSTANCE}" whoami)"
GUEST_HOME="/home/${GUEST_USER}.guest"

# ensure target directories exist
limactl shell "${INSTANCE}" bash -c 'mkdir -p ~/.config/nvim ~/.kiro/skills ~/.tmp'

echo "📦 Copying dotfiles..."

# copy dotfiles into the VM
limactl copy -r config/.config/nvim "${INSTANCE}:${GUEST_HOME}/.config/nvim"
limactl copy -r config/.kiro "${INSTANCE}:${GUEST_HOME}/.kiro"
limactl copy config/.standard.yml "${INSTANCE}:${GUEST_HOME}/.standard.yml"
limactl copy config/.tmux.conf "${INSTANCE}:${GUEST_HOME}/.tmux.conf"
limactl copy config/.bash_custom "${INSTANCE}:${GUEST_HOME}/.bash_custom"
limactl shell "${INSTANCE}" bash -c 'echo "source ~/.bash_custom" >> ~/.bashrc'

# install nvim plugins (requires dotfiles to be in place)
echo "📦 Installing nvim plugins..."
limactl shell "${INSTANCE}" bash -c 'nvim --headless -u ~/.config/nvim/.vimrc "+PlugInstall --sync" +qall 2>/dev/null'
limactl shell "${INSTANCE}" bash -c 'nvim --headless +TSUpdate +qall 2>/dev/null'
limactl shell "${INSTANCE}" bash -c 'nvim --headless "+helptags ALL" +qall 2>/dev/null'

echo "✅ Dotfiles provisioned into ${INSTANCE}"
