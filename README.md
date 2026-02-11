# README - Dotfile

### Dependencies
* tpm - https://github.com/tmux-plugins/tpm
* pyenv - https://github.com/pyenv/pyenv
* neovim - https://github.com/neovim/neovim/blob/master/INSTALL.md

### Todo

- ~~Add keymap for gitsigns blame~~
- fix telescope for `lsp_references` to show file name first then path
    - right now go to references is hard to read the file since in current project file paths are LONG
- add dap and configure it for javascript
- get copilot chat keymap working
- debugger for react and node
- lsp reference telescope fix it so it's now showing the entire file path
- **TODO (2026-02-11)**: Re-add rest.nvim plugin for HTTP/REST API testing
    - Requires proper setup of luarocks.nvim with Lua 5.1 compatibility
    - Dependencies: dkjson, mimetypes, xml2lua
    - Consider alternative: kulala.nvim (fewer dependencies)
