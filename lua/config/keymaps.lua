-- map leader
vim.keymap.set("n", "<Space>", "<NOP>", { noremap = true, silent = true, desc = "Disable space" })
vim.g.mapleader = " "
-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", "\"_dP", { noremap = true, silent = true, desc = "Paste over selected text" })

