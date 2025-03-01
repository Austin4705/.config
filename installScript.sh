echo "INSTALLING (for linux)"

cd ~/
sudo apt -y update
sudo apt -y install neovim
sudo apt -y install clang
sudo apt -y install zsh
sudo apt -y install eza

sudo git clone https://github.com/Austin4705/.config.git ~/.config
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
