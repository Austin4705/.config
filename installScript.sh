echo "INSTALLING"

cd ~/
sudo apt update
sudo apt install neovim
sudo apt install clang
cd ~/.config
cd zsh
mv .zshrc ~/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo git clone https://github.com/Austin4705/.config.git

#downloading

#Installing zsh
echo $ZSH_THEME
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k\necho 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
source ~/.zshrc
