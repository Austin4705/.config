echo "Austin's Install Script, Designed to get .config file operational in a single .sh file!"

sudo ln -s ~/.config/zsh/.zshrc ~/.zshrc
packages="git neovim clang zsh eza make clangd htop curl tmux"
morePackages="cairo openssl amass asio gawk baobab boost-devel btop ghc cabal-install ccache cloc dnsgen exa fd-find ffmpeg gcc ffuf freerdp fswatch fzf gh ghostscript glew-devel glfw-devel glm-devel gnupg2 graphviz gtk3-devel hashcat stack hydra libheif imagemagick jj john jq llvm luarocks masscan ncdu neovim nmap-ncat nikto nmap nodejs openblas-devel opam java-openjdk pandoc perl pinentry poppler-utils qemu ripgrep rust-analyzer rustup socat sqlmap sshpass stockfish stress swig tailscale tcpdump theharvester trash-cli wget whois wireshark"

if [ -f /etc/fedora-release ]; then
  echo "Detected Fedora"
  sudo dnf install -y $packages
  sudo dnf install -y $morePackages
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
  echo "Detected Ubuntu/Debian"
  sudo apt update
  sudo apt install -y $packages
  sudo apt install -y $packages
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected MacOS, install Homebrew!"
else
  echo "Unsupported OS"
  exit 1
fi

chsh -s $(which zsh)
