Austin's `.config` setup, should work on both linux and mac for configurations you would use on either (zsh, nvim, kitty, etc). Obviously things like aerospace are mac only

Version 1.1

Installing on say windows pc

```
wsl --install

sudo git clone https://github.com/Austin4705/.config.git ~/.config

# wget https://raw.githubusercontent.com/Austin4705/.config/#refs/heads/main/installScript.sh

cd /.config
sudo chmod +x ./installScript.sh
sudo ./installScript.sh
```
