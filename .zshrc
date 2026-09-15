export ZSH_DISABLE_COMPFIX=true
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

plugins=(git web-search aws)

source $ZSH/oh-my-zsh.sh

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
alias killrails="kill -9 $(lsof -i tcp:3000 -t)"
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

# For WSL
#alias pbcopy='xclip -selection clipboard'
#alias pbpaste='xclip -selection clipboard -o'


export GOPATH=~/go

eval $(thefuck --alias)

# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.functions

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# export PATH="$PATH:/usr/local/go/bin"
# export PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"
#
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - bash)"
# export PATH="/opt/nvim-linux-x86_64/bin:$PATH"
#
# set synctex-editor-command "gvim --servername VIM --remote-silent +%{line} %{input}"
export PATH="$PATH:/Library/TeX/texbin"
export CLASS_DIR=math6316
