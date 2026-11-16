export ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# nvm loads on first use of node/npm/nvm instead of at startup
zstyle ':omz:plugins:nvm' lazy yes
plugins=(git web-search aws nvm)

# Homebrew completions must be on fpath before omz runs compinit
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export LESS=-RX

bindkey -e
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

alias vi="nvim"
alias py="python3"
alias me="nvim ~/.zshrc"
alias vime="nvim ~/.vimrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias tmuxme="nvim ~/.tmux.conf"
alias webs="python3 -m http.server 4000"
alias vimgo="nvim -u ~/.vimrc.go"
alias ngrk="~/Downloads/./ngrok"
alias mtest="ruby -r minitest/pride --verbose"
alias g="google"
alias pgstart="brew services start postgresql"
alias pgstop="brew services stop postgresql"
alias elint="node_modules/eslint/bin/eslint.js"
alias kc="kubectl"
alias repos='cd $(find ~/projects -maxdepth 1 -type d | fzf)'

# Fuzzy-find a file or directory, then jump to its directory.
fcd() {
  local root="${1:-.}" selected
  root="${root:A}"
  [[ -d "$root" ]] || { print -u2 -- "Not a directory: $root"; return 1; }

  selected=$(
    find "$root" \( -type d -o -type f \) -print0 |
      fzf --read0 --print0 --prompt='Jump to location > '
  ) || return
  selected="${selected%$'\0'}"
  [[ -n "$selected" ]] || return

  [[ -d "$selected" ]] || selected="${selected:h}"
  builtin cd -- "$selected"
}

# Machine-local helpers (not in this repo); sourced after the aliases above so they can override them
for file in ~/.{functions,aliases,aliases_platform}; do
  [[ -r "$file" && -f "$file" ]] && source "$file"
done
unset file

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

(( $+commands[thefuck] )) && eval "$(thefuck --alias)"
# fzf >= 0.48 ships its own zsh integration; older versions fall back in the OS file
(( $+commands[fzf] )) && source <(fzf --zsh 2>/dev/null)

# OS-specific config (installed by `make zsh`), then secrets/work config that never goes in this repo
[[ -r ~/.zshrc.os ]] && source ~/.zshrc.os
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
