# macOS-only config. Installed to ~/.zshrc.os by `make zsh`.

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
(( $+commands[pyenv] )) && eval "$(pyenv init - --no-rehash zsh)"

# Poetry
export PATH="$HOME/.local/bin:$PATH"
# Rancher Desktop
export PATH="$PATH:$HOME/.rd/bin"
export PATH="$PATH:/Library/TeX/texbin"
# Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# Current kubernetes context in the prompt: https://github.com/jonmosco/kube-ps1
if [[ -r /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh ]]; then
  source /opt/homebrew/opt/kube-ps1/share/kube-ps1.sh
  PS1="$PS1"' $(kube_ps1) '
fi

/usr/libexec/java_home >/dev/null 2>&1 && export JAVA_HOME=$(/usr/libexec/java_home)

# Must stay last for SDKMAN to work
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
