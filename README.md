# Neovim Configuration

<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugin-manager?style=flat" /></a>

This is my Neovim configuration. It uses recent and maintained plugins with a focus on performance and a complete developer experience. Load times in around 30ms on an 8 core laptop.
## Motivation
The motivation to maintain my own configuration is two fold:
1) Support unique aspects of my workflow (NixOS, Wezterm, Neovide, etc)
2) I understand exactly why everything works the way it does, as I wrote and maintain the *entire* config

#### Features
- Robust and automatic session management *per branch* in directories, as well as the ability to create custom sessions.
- Popular and functional colorschemes preinstalled
- Modern UI with Noice, nvim-notify, and others
- Almost entirely lazy loaded
- Searchable (`<space>ek`), well documented, and thorough keymappings
- LSP, DAP, and linting, all completely language agnostic
- Treesitter textobject bindings that will become staples of your workflow

#### How I Got Here
The original impetus to hand crafted my own configuration was to ensure that I understood *everything* my Neovim configuration was capable of. Starting from a completely unmodified Neovim instance, I slowly added functionality (with packer.nvim, the, at the time, de facto plugin manager), as I needed and wanted, **but only once fully understanding what I already had**. I would research all plugins which provided a specific functionality, and their advantages and disadvantages, before adding them to ensure that I got the best and most up to date experience possible.

As time passed, I adopted [lazy.nvim](https://github.com/folke/lazy.nvim), greatly improving my config's performance with lazy loading, added dozens plugins to my config, and swapped old plugins to more modern alternatives, getting me to where I am now. While I still firmly believe that everyone should start with plain Neovim (before diving into highly complex plugins and distros), I don't know if I could recommend starting from complete scratch as I did, especially if your workflow is more typical. Newer distros such as [LazyVim](https://www.lazyvim.org/) provide such a good baseline without sacrificing configurability.

The are many good arguments to be made for distros: time saved messing with configs, better support when things break, powerful features and customizations, and much more. Despite that, I would still very much recommend everyone spends time to fully understand Vim/Neovim *completely*, as well as take time to understand your all the plugins your config provides, as the real power of Neovim only unlocks when you are using every feature of your configuration to your *advantage*, instead of fighting with key-mappings you can't remember, and nurturing bad habits like spamming hjkl to get anywhere in your code, because you never did the built in Neovim tutorial.

While newer distros such as [LazyVim](https://www.lazyvim.org/) have greatly improved in striking a balance between providing good defaults and setups for common needs while still allowing complete customization, I have stuck with my config as I don't really get much (at this point) from migrating to a modified distro. I would have to learn all the idiosyncrasies of that config, and then end up rewriting half of it just to suit my workflow.


#### Caveats
This config may contain some helpful examples of how to customize and configure Neovim and particular plugins (listed below), but serves pretty much *only* as that, as the config is completely tailored to my immediate needs and desires. This is reflected in the number of plugins (77 total, 49 loaded with a `.c` file open) vs Neovim distro's like [LazyVim](https://www.lazyvim.org/)'s (43 plugins total, 28 loaded with a `.c` file open as of Aug 2024) with almost identical base functionality.

## Install Steps

1. First clone this repo into `~/.config/` with a command like the following:

`git clone https://github.com/xyven1/neovim-config.git ~/.config/nvim`

or if you already have a config

`git clone https://github.com/xyven1/neovim-config.git ~/.config/xyven1/neovim-config`

Note: if you use the second option run Neovim with `NVIM_APPNAME=xyven1/neovim-config/`


2. Install Neovim **>=v0.10.0** from your package manager, or use the following script:  `~/.config/nvim/scripts/nvim.sh`
4. Install the dependencies listed below (ones necessary for basic functionality are marked with !)
3. Run the command `nvim` and let Lazy.nvim do its thing, then run `:COQdeps` to install the dependencies for `coq_nvim`
4. Restart Neovim, and everything should work.

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

+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
+ [Mofiqul/vscode.nvim](https://dotfyle.com/plugins/Mofiqul/vscode.nvim)
+ [olimorris/onedarkpro.nvim](https://dotfyle.com/plugins/olimorris/onedarkpro.nvim)
+ [sainnhe/gruvbox-material](https://dotfyle.com/plugins/sainnhe/gruvbox-material)
### comment

+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
+ [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
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

+ [monaqa/dial.nvim](https://dotfyle.com/plugins/monaqa/dial.nvim)
+ [tzachar/highlight-undo.nvim](https://dotfyle.com/plugins/tzachar/highlight-undo.nvim)
+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)
### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
+ [nvim-tree/nvim-tree.lua](https://dotfyle.com/plugins/nvim-tree/nvim-tree.lua)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
+ [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)
### git

+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
+ [kdheepak/lazygit.nvim](https://dotfyle.com/plugins/kdheepak/lazygit.nvim)
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
### github

+ [pwntester/octo.nvim](https://dotfyle.com/plugins/pwntester/octo.nvim)
### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
### indent

+ [NMAC427/guess-indent.nvim](https://dotfyle.com/plugins/NMAC427/guess-indent.nvim)
+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [simrat39/symbols-outline.nvim](https://dotfyle.com/plugins/simrat39/symbols-outline.nvim)
+ [ray-x/lsp_signature.nvim](https://dotfyle.com/plugins/ray-x/lsp_signature.nvim)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [glepnir/lspsaga.nvim](https://dotfyle.com/plugins/glepnir/lspsaga.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### markdown-and-latex

+ [toppair/peek.nvim](https://dotfyle.com/plugins/toppair/peek.nvim)
### motion

+ [ggandor/leap.nvim](https://dotfyle.com/plugins/ggandor/leap.nvim)
### nvim-dev

+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### quickfix

+ [kevinhwang91/nvim-bqf](https://dotfyle.com/plugins/kevinhwang91/nvim-bqf)
### search

+ [nvim-pack/nvim-spectre](https://dotfyle.com/plugins/nvim-pack/nvim-spectre)
### session

+ [stevearc/resession.nvim](https://dotfyle.com/plugins/stevearc/resession.nvim)
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

+ [kazhala/close-buffers.nvim](https://dotfyle.com/plugins/kazhala/close-buffers.nvim)
+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
