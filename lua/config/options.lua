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

-- neovide settings
vim.g.neovide_transparency = 0.9
vim.g.terminal_color_0 = '#1e1e1e'
vim.g.terminal_color_1 = '#f44747'
vim.g.terminal_color_2 = '#608b4e'
vim.g.terminal_color_3 = '#dcdcaa'
vim.g.terminal_color_4 = '#569cd6'
vim.g.terminal_color_5 = '#c678dd'
vim.g.terminal_color_6 = '#56b6c2'
vim.g.terminal_color_7 = '#d4d4d4'
vim.g.terminal_color_8 = '#808080'
vim.g.terminal_color_9 = '#f44747'
vim.g.terminal_color_10 = '#608b4e'
vim.g.terminal_color_11 = '#dcdcaa'
vim.g.terminal_color_12 = '#569cd6'
vim.g.terminal_color_13 = '#c678dd'
vim.g.terminal_color_14 = '#56b6c2'
vim.g.terminal_color_15 = '#d4d4d4'
vim.o.guifont = 'JetBrainsMono Nerd Font:h12'

vim.opt.fillchars:append { diff = "╱" }
vim.opt.wildignore:append { "blue.vim", "darkblue.vim", "default.vim",
  "delek.vim", "desert.vim", "elflord.vim", "evening.vim", "habamax.vim",
  "industry.vim", "koehler.vim", "lunaperche.vim", "morning.vim", "murphy.vim",
  "pablo.vim", "peachpuff.vim", "quiet.vim", "retrobox.vim", "ron.vim",
  "shine.vim", "slate.vim", "sorbet.vim", "torte.vim", "wildcharm.vim",
  "zaibatsu.vim", "zellner.vim" }
