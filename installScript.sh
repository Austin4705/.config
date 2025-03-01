echo "INSTALLING (for linux)"

sudo apt -y update
sudo apt -y install neovim
sudo apt -y install clang
sudo apt -y install zsh
sudo apt -y install eza
sudo apt -y install make
sudo apt -y install clangd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
sudo cp ~/.config/zsh/.zshrc ~/.zshrc
sudo cp ~/.config/zsh/.p10k.zsh ~/.p10k.zsh
