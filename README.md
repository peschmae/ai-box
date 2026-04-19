# ai-box

Jail common AI tooling into a VM box 🤖🔒

An isolated VM environment pre-loaded with AI coding agents (Claude Code, Kiro CLI) and a full development stack. Keeps AI agents sandboxed so they can't directly read, write, or execute files on your host.

## What's inside

- **Languages**: Go 1.25, Ruby 3.2, Python 3.13, Node 22 (via mise)
- **AI agents**: Claude Code, Kiro CLI
- **Tools**: neovim, tmux, kubectl, sops, age, ansible, prettier, standardrb
- **Containers**: containerd + nerdctl (Lima native)

## Setup

Two VM backends are supported:

### Lima (recommended)

Requires [Lima](https://lima-vm.io/) >= 2.1. Supports `limactl shell --sync` for safe, reviewable file synchronization with the host.

```bash
# initial setup
./lima-setup.sh

# start and sync your project into the VM
cd /path/to/project
./path/to/lima-box.sh

# stop the VM
./lima-suspend.sh

# re-provision dotfiles after changes
./lima-provision.sh
```

The `--sync` workflow copies your working directory into the VM. When you exit, Lima prompts you to accept, reject, or diff the changes before syncing back to the host.

### Vagrant / VirtualBox

```bash
# start and ssh in
./ai-box.sh

# suspend the VM
./ai-suspend.sh

# hot-swap the shared project folder
./swap-folder.sh /path/to/other/project
```

Uses a persistent shared folder (`~/04_virt/projects` → `/home/vagrant/projects`).

## Configuration

Dotfiles and editor configs live in `config/`:

```
config/
├── .bashrc
├── .tmux.conf
├── .standard.yml
├── .config/nvim/      # neovim setup (vim-plug, treesitter)
└── .kiro/skills/      # kiro skill profiles
```

## Prerequisites

- Export `AWS_IDENTITY_PROVIDER_URL` and `AWS_REGION`, or populate `~/.aws_identity_provider`:
  ```bash
  export AWS_IDENTITY_PROVIDER_URL="<url>"
  export AWS_REGION="<region>"
  ```
