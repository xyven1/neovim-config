# Neovim Configuration

<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugin-manager?style=flat" /></a>

This is my neovim configuration. It uses recent and maintained plugins with a focus on performance and a complete developer experience. Load times in around 30ms on an 8 core laptop.

Some nice features include:
- Robust and automatic session management *per branch* in directories, as well as the ability to create custom sessions.
- Popular and functional colorschemes preinstalled
- Modern ui with Noice, nvim-notify, and others
- Almost entirely lazy loaded
- Searchable (`<space>ek`), well documented, and thorough keymappings
- LSP, DAP, and linting, all completely language agnostic
- Treesitter textobject bindings that will become staples of your workflow

## Install Steps

1. First clone this repo into `~/.config/` with the a command like the following:

`git clone https://github.com/xyven1/neovim-config.git ~/.config/nvim`

or if you already have a config

`git clone https://github.com/xyven1/neovim-config.git ~/.config/xyven1/neovim-config`

Note: if you use the second option run neovim with `NVIM_APPNAME=xyven1/neovim-config/`


2. Install neovim **>=v0.10.0** from your package manager, or use the following script:  `~/.config/nvim/scripts/nvim.sh`
4. Install the dependencies listed below (ones necessary for basic functionality are marked with !)
3. Run the command `nvim` and let Lazy.nvim do its thing, then run `:COQdeps` to install the dependecies for `coq_nvim`
4. Restart nvim, and everything should work.

## External dependencies
- !python > 3.8.2 (for coq_nvim)
- !python3-venv (for coq_nvim)
- !fzf
- !ripgrep
- direnv (for loading development environments)

## Plugins

### code-runner

+ [stevearc/overseer.nvim](https://dotfyle.com/plugins/stevearc/overseer.nvim)
+ [Zeioth/compiler.nvim](https://dotfyle.com/plugins/Zeioth/compiler.nvim)
### colorscheme

+ [sainnhe/gruvbox-material](https://dotfyle.com/plugins/sainnhe/gruvbox-material)
+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
+ [Mofiqul/vscode.nvim](https://dotfyle.com/plugins/Mofiqul/vscode.nvim)
+ [olimorris/onedarkpro.nvim](https://dotfyle.com/plugins/olimorris/onedarkpro.nvim)
### comment

+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
+ [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
### completion

+ [ms-jpq/coq_nvim](https://dotfyle.com/plugins/ms-jpq/coq_nvim)
### cursorline

+ [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)
### debugging

+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
### diagnostics

+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
### editing-support

+ [tzachar/highlight-undo.nvim](https://dotfyle.com/plugins/tzachar/highlight-undo.nvim)
+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)
+ [monaqa/dial.nvim](https://dotfyle.com/plugins/monaqa/dial.nvim)
### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
+ [nvim-tree/nvim-tree.lua](https://dotfyle.com/plugins/nvim-tree/nvim-tree.lua)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
+ [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)
### git

+ [kdheepak/lazygit.nvim](https://dotfyle.com/plugins/kdheepak/lazygit.nvim)
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
### github

+ [pwntester/octo.nvim](https://dotfyle.com/plugins/pwntester/octo.nvim)
### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [simrat39/symbols-outline.nvim](https://dotfyle.com/plugins/simrat39/symbols-outline.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [glepnir/lspsaga.nvim](https://dotfyle.com/plugins/glepnir/lspsaga.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### markdown-and-latex

+ [toppair/peek.nvim](https://dotfyle.com/plugins/toppair/peek.nvim)
### motion

+ [ggandor/leap.nvim](https://dotfyle.com/plugins/ggandor/leap.nvim)
### nvim-dev

+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### quickfix

+ [kevinhwang91/nvim-bqf](https://dotfyle.com/plugins/kevinhwang91/nvim-bqf)
### search

+ [nvim-pack/nvim-spectre](https://dotfyle.com/plugins/nvim-pack/nvim-spectre)
### split-and-window

+ [mrjones2014/smart-splits.nvim](https://dotfyle.com/plugins/mrjones2014/smart-splits.nvim)
### startup

+ [nvimdev/dashboard-nvim](https://dotfyle.com/plugins/nvimdev/dashboard-nvim)
### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
### syntax

+ [kylechui/nvim-surround](https://dotfyle.com/plugins/kylechui/nvim-surround)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
### tabline

+ [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)
### test

+ [andythigpen/nvim-coverage](https://dotfyle.com/plugins/andythigpen/nvim-coverage)
### utility

+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
+ [kazhala/close-buffers.nvim](https://dotfyle.com/plugins/kazhala/close-buffers.nvim)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)

