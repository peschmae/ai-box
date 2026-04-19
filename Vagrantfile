# vm_name = File.basename(Dir.getwd)
vm_name = "ai-box"

# source host env vars for AWS identity provider
File.readlines(File.expand_path("~/.aws_identity_provider")).each do |line|
  key, value = line.strip.match(/^export\s+(\w+)=["']?(.+?)["']?$/)&.captures
  ENV[key] = value if key
end

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"

  # config.vm.synced_folder ".", "/home/vagrant/projects", type: "virtualbox"
  config.vm.synced_folder File.expand_path("~/04_virt/projects"), "/home/vagrant/projects", type: "virtualbox", id: "projects", owner: "vagrant", group: "vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "8192"
    vb.cpus = 4
    vb.gui = false
    vb.name = vm_name
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
  end

  ## use this in case any specific localhost:port access from VM->Host is needed
  # config.ssh.extra_args = [
  #   "-R", "9999:localhost:9999",
  #   "-R", "9090:localhost:9090",
  #   "-R", "9000:localhost:9000",
  #   "-R", "8080:localhost:8080",
  #   "-R", "3000:localhost:3000",
  #   "-R", "5432:localhost:5432"
  # ]

  ## or this for the other way around (Host->VM)
  # config.vm.network "forwarded_port", guest: 9999, host: 9999, auto_correct: true
  # config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  # config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

  # config files
  config.vm.provision "file", source: "config/.config/nvim", destination: "~/.config/nvim"
  config.vm.provision "file", source: "config/.config/kilo", destination: "~/.config/kilo"
  config.vm.provision "file", source: "config/.config/opencode", destination: "~/.config/opencode"
  config.vm.provision "file", source: "config/.kiro/agents", destination: "~/.kiro/agents"
  config.vm.provision "file", source: "config/.kiro/settings", destination: "~/.kiro/settings"
  config.vm.provision "file", source: "config/.kiro/skills", destination: "~/.kiro/skills"
  config.vm.provision "file", source: "config/.standard.yml", destination: "~/.standard.yml"
  config.vm.provision "file", source: "config/.tmux.conf", destination: "~/.tmux.conf"
  config.vm.provision "file", source: "config/.bashrc", destination: "~/.bashrc"
  config.vm.provision "file", source: "config/bin", destination: "~/bin"

  # root
  config.vm.provision "shell", privileged: true,
    env: {
      "AWS_IDENTITY_PROVIDER_URL" => ENV.fetch("AWS_IDENTITY_PROVIDER_URL"),
      "AWS_REGION" => ENV.fetch("AWS_REGION")
    },
<<<<<<< HEAD
    inline: <<~SHELL
          # profile env vars
          cat > /etc/profile.d/aws_identity_provider.sh << EOF
      export AWS_IDENTITY_PROVIDER_URL="${AWS_IDENTITY_PROVIDER_URL}"
      export AWS_REGION="${AWS_REGION}"
      EOF
          # basics
          export DEBIAN_FRONTEND=noninteractive
          apt-get update
          apt-get install -y docker.io git unzip bzip2 tmux ruby-dev python3-dev \
            curl wget jq ca-certificates apt-transport-https parallel util-linux \
            iputils-arping iputils-clockdiff iputils-ping iputils-tracepath iproute2 \
            cmake openssl dnsutils uuid-runtime netcat-openbsd gettext-base lsb-release psmisc \
            iptables ethtool wireguard net-tools traceroute apache2-utils openssh-client \
            libreadline-dev libtool libssl-dev libffi-dev libyaml-dev libz-dev chrony \
            bsdextrautils fonts-noto-color-emoji fonts-noto-core fonts-symbola
      
          # install latest neovim from github releases
          NVIM_ARCH="$(uname -m | sed 's/aarch64/arm64/')"
          curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" | tar xz -C /opt
          ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
          ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/vim
      
          # kubectl
          curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
          echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' > /etc/apt/sources.list.d/kubernetes.list
          apt-get update
          apt-get install -y kubectl
      
          # sops
          VM_ARCH="$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')"
          SOPS_VERSION="v3.11.0"
          curl -fsSLo /usr/local/bin/sops https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${VM_ARCH}
          chmod +x /usr/local/bin/sops
      
          # age
          AGE_VERSION="v1.3.1"
          curl -fsSL "https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-${VM_ARCH}.tar.gz" | tar xz -C /usr/local/bin --strip-components=1 age/age age/age-keygen
          chmod +x /usr/local/bin/age
          chmod +x /usr/local/bin/age-keygen
      
          usermod -aG docker vagrant
          chown -R vagrant:vagrant /home/vagrant/projects
    SHELL
=======
    inline: <<-SHELL
    # profile env vars
    cat > /etc/profile.d/aws_identity_provider.sh << EOF
export AWS_IDENTITY_PROVIDER_URL="${AWS_IDENTITY_PROVIDER_URL}"
export AWS_REGION="${AWS_REGION}"
EOF
    # basics
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y docker.io git unzip bzip2 tmux ruby-dev python3-dev \
      curl wget jq ca-certificates apt-transport-https parallel util-linux \
      iputils-arping iputils-clockdiff iputils-ping iputils-tracepath iproute2 \
      cmake openssl dnsutils uuid-runtime netcat-openbsd gettext-base lsb-release psmisc \
      iptables ethtool wireguard net-tools traceroute apache2-utils openssh-client \
      libreadline-dev libtool libssl-dev libffi-dev libyaml-dev libz-dev chrony \
      bsdextrautils fonts-noto-color-emoji fonts-noto-core fonts-symbola

    # install neovim (pinned to avoid treesitter ABI mismatches)
    NVIM_VERSION="v0.12.1"
    NVIM_ARCH="$(uname -m | sed 's/aarch64/arm64/')"
    curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" | tar xz -C /opt
    ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
    ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/vim

    # kubectl
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' > /etc/apt/sources.list.d/kubernetes.list
    apt-get update
    apt-get install -y kubectl

    # sops
    VM_ARCH="$(uname -m | sed 's/x86_64/amd64/' | sed 's/aarch64/arm64/')"
    SOPS_VERSION="v3.11.0"
    curl -fsSLo /usr/local/bin/sops https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${VM_ARCH}
    chmod +x /usr/local/bin/sops

    # age
    AGE_VERSION="v1.3.1"
    curl -fsSL "https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-${VM_ARCH}.tar.gz" | tar xz -C /usr/local/bin --strip-components=1 age/age age/age-keygen
    chmod +x /usr/local/bin/age
    chmod +x /usr/local/bin/age-keygen

    usermod -aG docker vagrant
    chown -R vagrant:vagrant /home/vagrant/projects
  SHELL
>>>>>>> 9eda612 (Add lima based vm setup)

  # vagrant
  config.vm.provision "shell", privileged: false,
    env: {
      "AWS_IDENTITY_PROVIDER_URL" => ENV.fetch("AWS_IDENTITY_PROVIDER_URL"),
      "AWS_REGION" => ENV.fetch("AWS_REGION")
    },
    inline: <<-SHELL
    export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

    # taskfile
    curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash

    # mise-en-place
    curl https://mise.run | sh
    mise --version
    eval "$(mise activate bash)"

    # mise languages
    mise install golang@1.22.12
    mise install golang@1.24.12
    mise use --global golang@1.25.6
    mise use --global ruby@3.2.10
    mise use --global python@3.13.11
    mise use --global node@22

    # golang tools
    go install golang.org/x/tools/gopls@latest
    go install golang.org/x/tools/cmd/goimports@latest

    # install venv & ansible
    pip install --user virtualenv
    pip install --user ansible
    pip install --user yamllint
    pip install --user pgcli

    # nodejs tools
    npm install -g prettier

    # install bundler
    gem install bundler

    # install useful ruby gems
    gem install httparty
    gem install rest-client
    gem install deep_merge
    gem install hashdiff
    gem install fugit
    gem install chronic
    gem install json
    gem install rexml
    gem install standard
    gem install standardrb
    gem install ruby-lsp

    # setup nvim
    mkdir -p ~/.tmp
    nvim --headless -u ~/.config/nvim/.vimrc +'PlugInstall --sync' +qall
    nvim --headless +TSUpdate +qall
    nvim --headless +'helptags ALL' +qall

    # claude
    npm install -g @anthropic-ai/claude-code --no-audit
    claude --version

    # kiro
    curl -fsSL https://cli.kiro.dev/install | bash || true
    kiro-cli --version

    # opencode
    npm install -g opencode-ai --no-audit
    opencode --version
    SHELL
end
