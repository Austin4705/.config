echo "INSTALLING (for linux)"

cd ~/
sudo apt update
sudo apt install neovim
sudo apt install clang
sudo apt install zsh

sudo mv ~/.config/zsh/.zshrc ~/.zshrc
sudo mv ~/.config/zsh/.p10k.zsh ~/.p10k.zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo git clone https://github.com/Austin4705/.config.git ~/

#downloading

#Installing zsh
echo $ZSH_THEME
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k\necho 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
source ~/.zshrc
