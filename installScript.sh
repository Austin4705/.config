#!/usr/bin/env bash
set -euo pipefail
echo "Austin's one-shot install script"

# Safer symlink (no sudo, overwrite if it exists)
ln -sf ~/.config/zsh/.zshrc ~/.zshrc

common_pkgs="git neovim clang zsh make clangd htop curl tmux"

dnf_pkgs="cairo openssl amass asio gawk baobab boost-devel btop ghc \
  cabal-install ccache cloc dnsgen exa fd-find ffmpeg gcc ffuf freerdp \
  fswatch fzf gh ghostscript glew-devel glfw-devel glm-devel gnupg2 \
  graphviz gtk3-devel hashcat stack hydra libheif imagemagick jj john jq \
  llvm luarocks masscan ncdu neovim nmap-ncat nikto nmap nodejs \
  openblas-devel opam java-openjdk pandoc perl pinentry poppler-utils qemu \
  ripgrep rust-analyzer rustup socat sqlmap sshpass stockfish stress swig \
  tailscale tcpdump theharvester trash-cli wget whois wireshark"

apt_pkgs="cairo libcairo2-dev openssl amass asio gawk baobab \
  libboost-all-dev btop ghc cabal-install ccache cloc dnsgen eza fd-find \
  ffmpeg gcc ffuf freerdp2-x11 fswatch fzf gh ghostscript libglew-dev \
  libglfw3-dev libglm-dev gnupg2 graphviz libgtk-3-dev hashcat haskell-stack \
  hydra libheif-dev imagemagick jj jq llvm luarocks masscan ncdu neovim \
  netcat-openbsd nikto nmap nodejs libopenblas-dev opam openjdk-17-jdk \
  pandoc perl pinentry-curses poppler-utils qemu-system ripgrep rust-analyzer \
  rustup socat sqlmap sshpass stockfish stress swig tcpdump theharvester \
  trash-cli wget whois wireshark"

if [[ -f /etc/fedora-release ]]; then
  echo "Detected Fedora"
  sudo dnf install -y $common_pkgs $dnf_pkgs

elif [[ -f /etc/debian_version || -f /etc/lsb-release ]]; then
  echo "Detected Debian / Raspbian"
  sudo apt update
  sudo apt install -y $common_pkgs $apt_pkgs

  # Optional: install tailscale if you need it
  # curl -fsSL https://tailscale.com/install.sh | sh
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected macOS – falling back to Homebrew"
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Unsupported OS"
  exit 1
fi

# Switch default shell
if command -v zsh >/dev/null; then
  chsh -s "$(command -v zsh)"
fi
