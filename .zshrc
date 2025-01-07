export ZSH_DISABLE_COMPFIX=true
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/edgargonzalez/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

plugins=(git web-search aws)

source $ZSH/oh-my-zsh.sh

alias vi="nvim"
alias py="python3"
alias me="vim ~/.zshrc"
alias vime="vim ~/.vimrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias tmuxme="vim ~/.tmux.conf"
alias webs="python3 -m http.server 4000"
alias killrails="kill -9 $(lsof -i tcp:3000 -t)"
alias vimgo="vim -u ~/.vimrc.go"
alias ngrk="~/Downloads/./ngrok"
alias mtest="ruby -r minitest/pride --verbose"
alias g="google"
alias pgstart="brew services start postgresql"
alias pgstop="brew services stop postgresql"
alias elint="node_modules/eslint/bin/eslint.js"
alias kc="kubectl"
alias repos='cd $(find ~/projects/platform -maxdepth 1 -type d | fzf)'
# For WSL
#alias pbcopy='xclip -selection clipboard'
#alias pbpaste='xclip -selection clipboard -o'

# For GoLang
#export PATH="$HOME/Development/goworkspace/bin:$PATH"
#export PATH="/usr/local/go/bin:$PATH"
#export ANDROID_HOME=~/Library/Android/sdk
#export PATH=${PATH}:${ANDROID_HOME}/tools
#export PATH=${PATH}:${ANDROID_HOME}/platform-tools

 # Powerline
# if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#     source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# fi


#export NVM_DIR="/Users/edgargonzalez/.nvm"
#[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export GOPATH=~/go
eval $(thefuck --alias)
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
