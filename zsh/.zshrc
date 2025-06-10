# Austin Wu's .zshrc file

# ————————————————————————————————————————————————————————————————
# Powerlevel10k Configuration
# ————————————————————————————————————————————————————————————————
source $HOME/.config/powerlevel10k/powerlevel10k.zsh-theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.config/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
# To customize prompt, run p10k configure or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


# ————————————————————————————————————————————————————————————————
# ZSH Setup
# ————————————————————————————————————————————————————————————————

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/zshhistory
setopt appendhistory
setopt autocd
export HISTCONTROL=ignoreboth

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -r "$HOME/.config/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source $HOME/.config/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -r "$HOME/.config/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
   source $HOME/.config/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# ————————————————————————————————————————————————————————————————
# Other program modifyers
# ————————————————————————————————————————————————————————————————

#For ocaml
# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/austinwu/.opam/opam-init/init.zsh' ]] || source '/Users/austinwu/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# ————————————————————————————————————————————————————————————————
# MacOS Specific Initlization
# ————————————————————————————————————————————————————————————————

if [[ "$(uname)" == "Darwin" ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  #
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export PATH="$PATH:/Users/austinwu/.lmstudio/bin"

  # Add trash-cli to PATH if installed
  if [ -d "/opt/homebrew/opt/trash-cli/bin" ]; then
    export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
  fi
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH" 
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
  export PATH="$(gem environment gemdir)/bin:$PATH"
fi

# ————————————————————————————————————————————————————————————————
# Custom User functions:
# ————————————————————————————————————————————————————————————————

mkcd() {
	mkdir $1 && cd $1
}

#Custom Function to use Templates well, should be placed in ~/Documents/Templates/
copyTemplate() {
    local src="$HOME/Documents/Templates/$1"
    local dest="$2"

    if [ ! -f "$src" ]; then
        echo "Error: Template '$1' not found in ~/Documents/Templates."
        return 1
    fi

    cp "$src" "$dest"
    echo "Copied '$src' to '$dest'."
}

#Backup Function, intended to seralize any condig data that is not stored inside a google drive backed up directory
#Goal is to update everything so perfect state repliaction
backup_system() {
    local backup_folder="$HOME/Documents/Backups/System"
    local today=$(date +"%Y-%m-%d")
    local backup_dir="$backup_folder/system_backup_$today"
    echo "Backup directory created at $backup_dir"

    #Backup all conda environments
    mkdir -p "$backup_dir/conda_envs"
    for env in $(conda env list | awk '{print $1}' | grep -v "#" ); do
        echo "Backing up Conda environment: $env"
        conda activate "$env"
        conda env export --no-builds > "$backup_dir/conda_envs/${env}.yml"
    done
    conda deactivate

    #Backup Homebrew installed packages
    echo "Backing up Homebrew Brewfile"
    brew bundle dump --file="$backup_dir/Brewfile" --force

    echo "Backup complete! 🎉"
}

# ————————————————————————————————————————————————————————————————
# Exports needed for various things
# ————————————————————————————————————————————————————————————————

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

export EDITOR=nvim
export TEXINPUTS=~/Documents/Templates//: #Needed so latex can always find my sty files
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export VCPKG_ROOT="~/Dev/vcpkg"
# export VCPKG_ROOT="$HOME/Documents/vcpkg/"

# Checks if path exists
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH" #Used for rust
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH" #Used for tdf

#Create a file called .apikeys inside of config and fill it with lines of 'export KEYNAME="key"' 
if [ -f ~/.config/.apikeys ]; then
  source ~/.config/.apikeys
fi

# ————————————————————————————————————————————————————————————————
# Alias listings for shortcuts
# ————————————————————————————————————————————————————————————————

# Create a safe rm alias
if command -v trash-put >/dev/null 2>&1; then
    alias rm='trash-put'
else
    alias rm='/bin/rm -i' # fallback to interactive rm
fi

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias la="eza -la --icons"
fi

alias v="nvim"
alias ya="yazi"
alias clr="clear"
alias q="exit"
alias cpcmp="clang++ -Wall -g -O3 -std=c++20"
alias skibiditoilet="echo dub dub dub yes yes"
alias goon="echo everyday"
alias img="kitty +kitten icat"
alias tc="latexmk -c" #TexClean
alias fclr="printf '\033c'"
alias gal="git add ."
alias gc="git commit -a -S -m"

