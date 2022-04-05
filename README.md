# neovim-config
This is my neovim configuration.

# Install Steps

1. First clone this repo into ~/.config/ with the a command like the following:

`git clone https://github.com/Xyven1/neovim-config.git ~/.config/nvim`

2. Use the nvim install script in `~/.config/nvim/scripts/nvim.sh` to install nvim
3. Install the dependencies listed below
3. Run the command `nvim`, and then `:PackerSync`
4. Restart nvim, and everything should work

# External Dependencies
- rust-analyzer (use scripts/rust-analyzer.sh)
- fzf >24 (manual install or Ubuntu release Impish)
- sumneko/lua-language-server (put files in .local and place symlink in .local/bin)
- python3-venv (for coq_nvim)
