local o = vim.opt
local g = vim.g

o.expandtab = true -- convert tabs to spaces
o.ignorecase = true -- ignore case in search patterns
o.number = true -- show line numbers
o.relativenumber = true -- show relative line numbers
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.smartindent = true -- make indenting smarter again
o.tabstop = 2 -- how many columns a tab counts for
o.termguicolors = true -- use terminal colors
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldlevelstart=99

g.suda_smart_edit = 1
g.vscode_style = "dark"
g.vscode_disable_nvimtree_bg = true
