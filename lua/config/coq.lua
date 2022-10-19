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

local expr_opts = { noremap = true, expr = true, silent = true }

vim.keymap.set('i', '<esc>', function() return vim.fn.pumvisible() == 1 and "<c-e><esc>" or "<esc>" end, expr_opts)
vim.keymap.set('i', '<c-c', function() return vim.fn.pumvisible() == 1 and "<c-e><c-c>" or "<c-c>" end, expr_opts)
vim.keymap.set('i', '<tab>', function() return vim.fn.pumvisible() == 1 and "<c-n>" or "<tab>" end, expr_opts)
vim.keymap.set('i', '<s-tab>', function() return vim.fn.pumvisible() == 1 and "<c-p>" or "<bs>" end, expr_opts)
