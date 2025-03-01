echo "INSTALLING (for linux)"

sudo apt -y update
sudo apt -y install neovim
sudo apt -y install clang
sudo apt -y install zsh
sudo apt -y install eza
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
