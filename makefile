OS := $(shell uname -s | sed 's/Darwin/macos/;s/Linux/linux/')

.PHONY: copy zsh

copy: zsh
	rm -rf ~/.config/nvim
	rm -rf ~/.config/ghostty
	cp -r .config/nvim ~/.config/
	cp -r .config/ghostty ~/.config/

# Installs the common zshrc + this OS's add-ons. Never overwrites ~/.zshrc.local (secrets).
zsh:
	@[ -f zsh/$(OS).zsh ] || { echo "unsupported OS: $(OS)"; exit 1; }
	@[ ! -f ~/.zshrc ] || (umask 077; cp ~/.zshrc ~/.zshrc.bak.$$(date +%Y%m%d%H%M%S))
	cp .zshrc ~/.zshrc
	cp zsh/$(OS).zsh ~/.zshrc.os
	@[ -f ~/.zshrc.local ] || { if [ -f zsh/local.example.zsh ]; then cp zsh/local.example.zsh ~/.zshrc.local; else touch ~/.zshrc.local; fi; echo "created ~/.zshrc.local: fill in work settings and secrets"; }
	chmod 600 ~/.zshrc ~/.zshrc.os ~/.zshrc.local
