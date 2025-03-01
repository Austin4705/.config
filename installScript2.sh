sudo mv ~/.config/zsh/.zshrc ~/.zshrc
sudo mv ~/.config/zsh/.p10k.zsh ~/.p10k.zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
