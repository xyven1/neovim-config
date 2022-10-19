vim.g.coq_settings = {
  auto_start = 'shut-up',
  clients = {
    -- tree_sitter = { enabled = false },
    buffers = { enabled = false },
    paths = { preview_lines = 3 }
  },
  display = { icons = { mode = 'short' } },
  keymap = { recommended = false },
}

local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<esc>', vim.fn.pumvisible() and "<c-e><esc>" or "<esc>", opts)
vim.keymap.set('i', '<c-c>', vim.fn.pumvisible() and "<c-e><c-c>" or "<c-c>", opts)
vim.keymap.set('i', '<tab>', vim.fn.pumvisible() and "<c-n>" or "<tab>", opts)
vim.keymap.set('i', '<s-tab>', vim.fn.pumvisible() and "<c-p>" or "<bs>", opts)
