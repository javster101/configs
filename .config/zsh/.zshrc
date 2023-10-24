# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/opt/gcc-arm-none-eabi-9-2020-q2-update/bin:$HOME/bin:$HOME/.local/bin:$HOME/.local/share/coursier/bin:$HOME/go/bin:$PATH"
export LESSOPEN="| src-hilite-lesspipe.sh %s" 
export LESS=" -R "

export SUDO_EDITOR="/usr/bin/nvim"

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

bindkey -v
VI_MODE_SET_CURSOR=true

plugins=(
  git 
  vi-mode
  gpg-agent 
  zsh-autosuggestions 
  command-not-found
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
alias config="/usr/bin/git --git-dir=$HOME/.cfgs --work-tree=$HOME"
alias tk="~/kiwi/kiwi_toolkit/toolkit"

function open () {
  xdg-open "$@">/dev/null 2>&1
}

function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
