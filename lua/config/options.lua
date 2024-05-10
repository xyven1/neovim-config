-- Set Vim options
vim.o.expandtab = true      -- convert tabs to spaces
vim.o.ignorecase = true     -- ignore case in search patterns
vim.o.number = true         -- show line numbers
vim.o.relativenumber = true -- show relative line numbers
vim.o.shiftwidth = 2        -- the number of spaces inserted for each indentation
vim.o.smartindent = true    -- make indenting smarter again
vim.o.tabstop = 2           -- how many columns a tab counts for
vim.o.termguicolors = true  -- use terminal colors
vim.o.pumblend = 30         -- popup menu transparency
vim.o.mouse = ''            -- disable mouse support
vim.g.mapleader = " "
vim.g.neovide_transparency = 0.9
vim.o.guifont = 'JetBrainsMono Nerd Font:h12'

vim.opt.fillchars:append { diff = "╱" }
vim.opt.wildignore:append { "blue.vim", "darkblue.vim", "default.vim",
  "delek.vim", "desert.vim", "elflord.vim", "evening.vim", "habamax.vim",
  "industry.vim", "koehler.vim", "lunaperche.vim", "morning.vim", "murphy.vim",
  "pablo.vim", "peachpuff.vim", "quiet.vim", "retrobox.vim", "ron.vim",
  "shine.vim", "slate.vim", "sorbet.vim", "torte.vim", "wildcharm.vim",
  "zaibatsu.vim", "zellner.vim" }
