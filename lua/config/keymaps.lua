local function opts_with_desc(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc
  }
end
-- map leader
vim.keymap.set("n", "<Space>", "<NOP>", opts_with_desc("Disable space"))
-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", "\"_dP", opts_with_desc("Paste over currently selected text without yanking it"))
vim.keymap.set('n', '<leader>m', function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, opts_with_desc('Toggle light/dark mode'))

-- keymaps to navigate between tabs
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', opts_with_desc('Previous tab'))
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', opts_with_desc('Next tab'))

-- keymaps to increase and decrease transparency
vim.keymap.set('n', '<leader>+', function()
  local new = vim.g.neovide_transparency + 0.1
  vim.g.neovide_transparency = new > 1 and 1 or new
end, opts_with_desc('Increase transparency'))
vim.keymap.set('n', '<leader>-', function()
  local new = vim.g.neovide_transparency - 0.1
  vim.g.neovide_transparency = new < 0 and 0 or new
end, opts_with_desc('Decrease transparency'))
