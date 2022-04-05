# neovim-config
This is my neovim configuration.

# Install Steps
First clone this repo into ~/.config/ with the a command like the following:
```git clone https://github.com/Xyven1/neovim-config.git ~/.config/nvim```
Use the nvim install script in nvim/scripts to install nvim
Install the dependencies listed below
run the command nvim, and then :PackerSync
Restart nvim, and everything should work

# External Dependencies
rust-analyzer                 (use scripts/rust-analyzer.sh)
fzf >24                       (manual install or Ubuntu release Impish)
sumneko/lua-language-server   (use scripts/lua.sh)
python3-venv
