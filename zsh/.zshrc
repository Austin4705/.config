#My stuff

if [[ "$(uname)" == "Darwin" ]]; then
  source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias ls="eza --icons"
alias la="eza -la --icons"
export EDITOR=nvim
# export EDITOR='emacsclient -c -a \"Emacs\"'

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/zshhistory
export HISTCONTROL=ignoreboth
setopt appendhistory
setopt autocd

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept
if [[ "$(uname)" == "Darwin" ]]; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

alias vi="nvim"
alias vim="nvim"
alias v="nvim"
alias clr="clear"
alias q="exit"
alias cpcmp="clang++ -Wall -g -O3 -std=c++20"
alias skibiditoilet="echo dub dub dub yes yes"
alias goon="echo everyday"
alias img="kitty +kitten icat"
alias tc="latexmk -c" #TexClean

mkcd() {
	mkdir $1 && cd $1
}

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/austinwu/.opam/opam-init/init.zsh' ]] || source '/Users/austinwu/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

export PATH="$HOME/.cargo/bin:$PATH"
# export PATH=~/.cargo/bin:$PATH    
export PATH="$HOME/.local/bin:$PATH"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent


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
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  # Added by LM Studio CLI (lms)
  export PATH="$PATH:/Users/austinwu/.lmstudio/bin"
fi
