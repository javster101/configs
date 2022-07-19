# Set XDG dir vars
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Moving things to XDG dirs
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
