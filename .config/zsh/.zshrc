# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/opt/nvim-linux64/bin:/opt/gcc-arm-none-eabi-9-2020-q2-update/bin:$HOME/bin:$HOME/.local/bin:$HOME/.local/share/coursier/bin:$HOME/go/bin:$PATH"
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
  fzf
)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

# config aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfgs --work-tree=$HOME"
alias nvim-zsh="nvim ~/.config/zsh/"
alias nvim-nvim="nvim ~/.config/nvim/"
alias nvim-kitty="nvim ~/.config/kitty/"

# git aliases
# alias gs="git status"
# alias gc="git commit"
# alias gca="git commit --amend"
# alias gcm="git commit -m"

# work aliases
alias tk="~/kiwi/kiwi_toolkit/toolkit"
alias kiwi="enter_dir_folder kiwi_docker ~/kiwi"
alias px4="enter_dir_folder kiwi_docker ~/px4"
alias hitl_fts="enter_dir_folder hitl_fts ~/hitl_fts"
alias in-air="DOCKER_HOST=tcp://192.168.2.100:2375"
alias in-payload="DOCKER_HOST=tcp://192.168.2.108:2375"
alias sitl-mrpayload="SIM_ENABLED=true SIM_SERVICE_IP_MAP=\"{\\\"payload_service\\\": \\\"172.28.0.22\\\"}\" RUST_LOG=debug cargo run"
alias sim-mrpayload="SIM_ENABLED=true SIM_SERVICE_IP_MAP=\"{\\\"payload_service\\\": \\\"127.0.0.1\\\"}\" RUST_LOG=debug cargo run"
export KIWI_NO_RUST_CONTAINER=true
export PX4_DIR="~/px4"

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
        if [[ -d ./.venv ]] ; then
          source ./.venv/bin/activate
        fi
      fi
  fi
}

function enter_dir_folder() {
  if [[ -z "$CONTAINER_ID" ]] ; then 
    distrobox enter --root "$1"
  else 
    cd "$2"
  fi
}

[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
