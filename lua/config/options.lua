-- Set Vim options
vim.opt.exrc = true           -- enable reading of .vimrc
vim.opt.expandtab = true      -- convert tabs to spaces
vim.opt.ignorecase = true     -- ignore case in search patterns
vim.opt.number = true         -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
vim.opt.smartindent = true    -- make indenting smarter again
vim.opt.tabstop = 2           -- how many columns a tab counts for
vim.opt.termguicolors = true  -- use terminal colors
vim.opt.pumblend = 10         -- popup menu transparency
vim.opt.mouse = ''            -- disable mouse support
vim.opt.scrolloff = 4
vim.opt.confirm = true
vim.opt.laststatus = 3
vim.opt.showbreak = '↪'
vim.opt.breakindent = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
vim.o.guifont = "JetBrains Mono,Symbols Nerd Font Mono:h12"

vim.opt.fillchars = {
  diff = '╱',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
  eob = ' '
}
vim.opt.wildignore:append { 'blue.vim', 'darkblue.vim', 'default.vim',
  'delek.vim', 'desert.vim', 'elflord.vim', 'evening.vim', 'habamax.vim',
  'industry.vim', 'koehler.vim', 'lunaperche.vim', 'morning.vim', 'murphy.vim',
  'pablo.vim', 'peachpuff.vim', 'quiet.vim', 'retrobox.vim', 'ron.vim',
  'shine.vim', 'slate.vim', 'sorbet.vim', 'torte.vim', 'wildcharm.vim',
  'zaibatsu.vim', 'zellner.vim' }

local icons = {
  [vim.diagnostic.severity.ERROR] = '󰅚 ',
  [vim.diagnostic.severity.WARN] = ' ',
  [vim.diagnostic.severity.INFO] = ' ',
  [vim.diagnostic.severity.HINT] = '󰌶 ',
}
vim.diagnostic.config({
  virtual_text = {
    source = 'if_many',
    prefix = function(diagnostic)
      for d, icon in pairs(icons) do
        if diagnostic.severity == d then
          return icon
        end
      end
      return ''
    end
  },
  severity_sort = true,
  signs = {
    text = icons,
  },
})
local signs = {
  DapBreakpoint = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
  DapBreakpointCondition = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
  DapBreakpointRejected = { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
  DapStopped = { text = '', texthl = '', linehl = 'DapStoppedLine', numhl = '' },
}
for name, value in pairs(signs) do
  vim.fn.sign_define(name, value)
end

vim.deprecate = function() end
