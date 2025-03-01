echo "INSTALLING (for linux)"

cd ~/
sudo apt -y update
sudo apt -y install neovim
sudo apt -y install clang
sudo apt -y install zsh
sudo apt -y install eza

sudo git clone https://github.com/Austin4705/.config.git ~/.config
sudo mv ~/.config/zsh/.zshrc ~/.zshrc
sudo mv ~/.config/zsh/.p10k.zsh ~/.p10k.zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
