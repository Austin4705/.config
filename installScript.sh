echo "Austin's Install Script, Designed to get .config file operational in a single .sh file!"

sudo ln -s ~/.config/zsh/.zshrc ~/.zshrc
packages="git neovim clang zsh eza make clangd htop curl"

if [ -f /etc/fedora-release ]; then
  echo "Detected Fedora"
  sudo dnf install -y $packages
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
  echo "Detected Ubuntu/Debian"
  sudo apt update
  sudo apt install -y $packages
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected MacOS, install Homebrew!"
else
  echo "Unsupported OS"
  exit 1
fi
