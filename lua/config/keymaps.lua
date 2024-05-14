local function opts(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc
  }
end
local map = vim.keymap.set
-- map leader
map("n", "<Space>", "<NOP>", opts("Disable space"))

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", "\"_dP", opts("Paste over currently selected text without yanking it"))
map('n', '<leader>m', function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, opts('Toggle light/dark mode'))

-- keymaps to navigate between tabs
map('n', '[t', '<cmd>tabprevious<cr>', opts('Previous tab'))
map('n', ']t', '<cmd>tabnext<cr>', opts('Next tab'))

-- keymaps to increase and decrease transparency
map('n', '<leader>+', function()
  local new = vim.g.neovide_transparency + 0.1
  vim.g.neovide_transparency = new > 1 and 1 or new
end, opts('Increase transparency'))
map('n', '<leader>-', function()
  local new = vim.g.neovide_transparency - 0.1
  vim.g.neovide_transparency = new < 0 and 0 or new
end, opts('Decrease transparency'))

-- terminal mappings
map('t', '<C-esc>', '<C-\\><C-n>', opts('Exit terminal mode'))
map('t', '<C-h>', '<cmd>wincmd h<cr>', opts('Go to the left window'))
map('t', '<C-j>', '<cmd>wincmd j<cr>', opts('Go to the bottom window'))
map('t', '<C-k>', '<cmd>wincmd k<cr>', opts('Go to the top window'))
map('t', '<C-l>', '<cmd>wincmd l<cr>', opts('Go to the right window'))

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

map("n", "<leader>\\", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

