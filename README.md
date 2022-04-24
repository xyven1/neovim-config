# Neovim Configuration
This is my neovim configuration.

# Install Steps

1. First clone this repo into ~/.config/ with the a command like the following:

`git clone https://github.com/Xyven1/neovim-config.git ~/.config/nvim`

2. Use asdf to install neovim (recommended), or use the following script:  `~/.config/nvim/scripts/nvim.sh`
3. Install the dependencies listed below
3. Run the command `nvim`, and then `:PackerSync`
4. Restart nvim, and everything should work

# External dependencies
- python3-venv (for coq_nvim)

# asdf dependencies
- neovim
- direnv
- fzf
- gitui
- rust
- rust-analyzer
- lua
- lua-language-server
- golang
- erland
- elixir
- nodejs
- haskell

Notes about asdf dependencies:
- In order to run any of these command with sudo the following alias must be used ```alias psudo='sudo env "PATH=$PATH"'```
- In order to avoid any slow downs due to shims, use direnv with a .envrc at / with the following lines ```DIRENV_LOG_FORMAT=''
use asdf```
