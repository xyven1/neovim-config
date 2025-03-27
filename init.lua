-- All non plugin related (vim) options
require('config/options')
-- Plugin management via Lazy
require('config/lazy')
-- Global keymaps
require('config/keymaps')
-- Vim autocommands/autogroups
require('config/autocmd')
-- Set colorscheme
vim.cmd [[set background=dark]]
vim.cmd [[colorscheme vscode]]
