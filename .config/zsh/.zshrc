# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/share/coursier/bin:$PATH"
export LESSOPEN="| src-hilite-lesspipe.sh %s" 
export LESS=' -R '

export SUDO_EDITOR='/usr/bin/nvim'

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git gradle gpg-agent ssh-agent)


function open () {
  xdg-open "$@">/dev/null 2>&1
}

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
alias config='/usr/bin/git --git-dir=$HOME/.cfgs --work-tree=$HOME'

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh