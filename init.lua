-- All non plugin related (vim) options
require("options")
-- Plugin management via Packer
require("plugins")
-- Set colorscheme
vim.cmd [[colorscheme vscode]]
-- Vim autocommands/autogroups
require("autocmd")
