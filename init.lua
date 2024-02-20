-- All non plugin related (vim) options
require("config/options")
-- Global keymaps
require("config/keymaps")
-- Plugin management via Lazy
require("config/lazy")
-- Set colorscheme
vim.cmd [[colorscheme vscode]]
-- Vim autocommands/autogroups
require("config/autocmd")
