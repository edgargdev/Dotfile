# Linux / WSL config. Installed to ~/.zshrc.os by `make zsh`.

for dir in /opt/nvim-linux-x86_64/bin /usr/local/go/bin /usr/local/texlive/2025/bin/x86_64-linux; do
  [[ -d $dir ]] && export PATH="$PATH:$dir"
done
unset dir

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
(( $+commands[pyenv] )) && eval "$(pyenv init - --no-rehash zsh)"

# Older apt fzf has no `fzf --zsh`; use its packaged scripts instead
if ! (( $+functions[fzf-file-widget] )); then
  for f in /usr/share/doc/fzf/examples/{key-bindings,completion}.zsh; do
    [[ -r $f ]] && source $f
  done
  unset f
fi

if [[ -n $WSL_DISTRO_NAME ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

export CLASS_DIR=math6316
