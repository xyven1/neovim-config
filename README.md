# Neovim Configuration

<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/xyven1/neovim-config"><img src="https://dotfyle.com/xyven1/neovim-config/badges/plugin-manager?style=flat" /></a>

This is my Neovim configuration. It uses recent and maintained plugins with a focus on performance and a complete developer experience. Load times in around 30ms on an 8 core laptop.
## Motivation
The motivation to maintain my own configuration is two fold:
1) Support unique aspects of my workflow (NixOS, Wezterm, Neovide, etc)
2) I understand exactly why everything works the way it does, as I wrote the *entire* config

### Features
- Robust and automatic session management *per branch* in directories, as well as the ability to create custom sessions.
- Popular and functional colorschemes preinstalled
- Modern UI with Noice, nvim-notify, and others
- Almost entirely lazy loaded
- Searchable (`<space>ek`), well documented, and thorough keymappings
- LSP, DAP, and linting which work well with NixOS 
- Treesitter textobject bindings that will become staples of your workflow

This config may contain some helpful examples of how to customize and configure Neovim, but pretty much *only* serves as that, as this config is completely tailored to my immediate needs and desires. If you use NixOS, then you find this configuration particularly interesting, as that is the OS is was written to support.

### How I got here, and why I think other people should conisder doing the same thing
The original impetus to hand-craft my own configuration was to ensure that I understood *everything* my Neovim configuration was capable of. I started from a completely unmodified Neovim instance and slowly added functionality as I needed or wanted, **but only after fully understanding what I already had**. This depth-first approach to configuration is crucial if you want an efficient and comfortable workflow. In general, ~80% of your workflow will consist of only a few actions, so it's *much* more important to make those actions fast than to have access to a wide array of less-used features.

Another key benefit of crafting your own configuration emerges during the process of adding new functionality. When confronted with the need (or desire) for new functionality, you have the opportunity to explore all plugins that provide that functionality. This has served two purposes in my experience. The first is straightforward: I could ensure I got the best and most up-to-date experience possible, avoiding dead or dying plugins. The second is more subtle: you don't know what you don't know. In the context of Neovim, this often meant discovering plugins that provided functionality I didn't even know was possible—yet which ended up becoming key parts of my workflow. Two examples are [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) and [oil.nvim](https://github.com/stevearc/oil.nvim). This kind of discovery only happens if you take the time to do the research, but the payoff is huge.

The upshot of all this is the following: I firmly believe everyone should start with plain Neovim before diving into highly complex plugins and distros. Neovim and Vim are, in their own right, powerful text editors—and at the end of the day, editing text makes up the vast majority of an IDE's responsibilities. So, before rushing to turn Neovim into an IDE, everyone should take the time to explore Neovim on its own, then add plugins to address specific workflow needs. The real power of Neovim only unlocks when you are using every feature of your configuration—and Neovim itself—to your *advantage*, instead of fighting with key mappings you can't remember or nurturing bad habits like spamming `hjkl` to get anywhere in your code because you never did the built-in Neovim tutorial. And unlike graphical IDEs, the functionality of Neovim is necessarily more obscured and difficult to discover through usage—that's essentially the exact issue graphical IDEs seek to address! You will only love Neovim if you fully embrace its philosophy, and not attempt to recreate what other tools can do better.

Despite this, I'm not sure I could recommend starting from complete scratch when transitioning to using Neovim as a full IDE, especially if your workflow is more typical. Newer distros such as [LazyVim](https://www.lazyvim.org/) provide a great baseline without sacrificing configurability. There are many good arguments to be made for distros: time saved messing with configs, better support when things break, powerful features and customizations, and more. I've stuck with my configuration because my workflow is fast, comfortable, and natural. Switching configurations would require that I learn all the idiosyncrasies of the new setup and probably end up rewriting half of it just to suit my needs.

## Install Steps

1. First clone this repo into `~/.config/` with a command like the following:

`git clone https://github.com/xyven1/neovim-config.git ~/.config/nvim`

or if you already have a config

`git clone https://github.com/xyven1/neovim-config.git ~/.config/xyven1/neovim-config`

If you use the second option run Neovim with the folling environment variable: `NVIM_APPNAME=xyven1/neovim-config/`


2. Install Neovim **>=v0.10.0** from your package manager, or use the following script:  `~/.config/nvim/scripts/nvim.sh`
4. Install the dependencies listed below (ones necessary for basic functionality are marked with !)
3. Run the command `nvim` and let Lazy.nvim do its thing.
4. Restart Neovim, and everything should work.

### External dependencies
- !fzf
- !ripgrep
- direnv (for loading development environments)
- lazygit (git UI)
- go (to build pendulum viewer)

## Plugins

### bars-and-lines

+ [luukvbaal/statuscol.nvim](https://dotfyle.com/plugins/luukvbaal/statuscol.nvim)
### code-runner

+ [Zeioth/compiler.nvim](https://dotfyle.com/plugins/Zeioth/compiler.nvim)
+ [stevearc/overseer.nvim](https://dotfyle.com/plugins/stevearc/overseer.nvim)
### colorscheme

+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
+ [Mofiqul/vscode.nvim](https://dotfyle.com/plugins/Mofiqul/vscode.nvim)
+ [sainnhe/gruvbox-material](https://dotfyle.com/plugins/sainnhe/gruvbox-material)
+ [olimorris/onedarkpro.nvim](https://dotfyle.com/plugins/olimorris/onedarkpro.nvim)
+ [rebelot/kanagawa.nvim](https://dotfyle.com/plugins/rebelot/kanagawa.nvim)
### colorscheme-creation

+ [rktjmp/lush.nvim](https://dotfyle.com/plugins/rktjmp/lush.nvim)
### comment

+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
+ [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
+ [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)
+ [danymat/neogen](https://dotfyle.com/plugins/danymat/neogen)
### competitive-programming

+ [kawre/leetcode.nvim](https://dotfyle.com/plugins/kawre/leetcode.nvim)
### completion

+ [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
### cursorline

+ [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)
### debugging

+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
### diagnostics

+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
### editing-support

+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [tzachar/highlight-undo.nvim](https://dotfyle.com/plugins/tzachar/highlight-undo.nvim)
+ [folke/snacks.nvim](https://dotfyle.com/plugins/folke/snacks.nvim)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)
+ [monaqa/dial.nvim](https://dotfyle.com/plugins/monaqa/dial.nvim)
### file-explorer

+ [stevearc/oil.nvim](https://dotfyle.com/plugins/stevearc/oil.nvim)
+ [nvim-neo-tree/neo-tree.nvim](https://dotfyle.com/plugins/nvim-neo-tree/neo-tree.nvim)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
+ [ibhagwan/fzf-lua](https://dotfyle.com/plugins/ibhagwan/fzf-lua)
### git

+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
### github

+ [pwntester/octo.nvim](https://dotfyle.com/plugins/pwntester/octo.nvim)
### icon

+ [nvim-tree/nvim-web-devicons](https://dotfyle.com/plugins/nvim-tree/nvim-web-devicons)
### indent

+ [NMAC427/guess-indent.nvim](https://dotfyle.com/plugins/NMAC427/guess-indent.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [mrcjkb/rustaceanvim](https://dotfyle.com/plugins/mrcjkb/rustaceanvim)
+ [hedyhli/outline.nvim](https://dotfyle.com/plugins/hedyhli/outline.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [glepnir/lspsaga.nvim](https://dotfyle.com/plugins/glepnir/lspsaga.nvim)
+ [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
### markdown-and-latex

+ [toppair/peek.nvim](https://dotfyle.com/plugins/toppair/peek.nvim)
+ [MeanderingProgrammer/render-markdown.nvim](https://dotfyle.com/plugins/MeanderingProgrammer/render-markdown.nvim)
### media

+ [3rd/image.nvim](https://dotfyle.com/plugins/3rd/image.nvim)
### motion

+ [ggandor/leap.nvim](https://dotfyle.com/plugins/ggandor/leap.nvim)
### nvim-dev

+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
+ [folke/lazydev.nvim](https://dotfyle.com/plugins/folke/lazydev.nvim)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### quickfix

+ [stevearc/quicker.nvim](https://dotfyle.com/plugins/stevearc/quicker.nvim)
### search

+ [MagicDuck/grug-far.nvim](https://dotfyle.com/plugins/MagicDuck/grug-far.nvim)
### session

+ [stevearc/resession.nvim](https://dotfyle.com/plugins/stevearc/resession.nvim)
### snippet

+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
### split-and-window

+ [mrjones2014/smart-splits.nvim](https://dotfyle.com/plugins/mrjones2014/smart-splits.nvim)
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

+ [ptdewey/pendulum-nvim](https://dotfyle.com/plugins/ptdewey/pendulum-nvim)
+ [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
+ [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
