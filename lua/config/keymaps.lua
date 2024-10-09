local function opts(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc
  }
end
local map = vim.keymap.set
-- map leader
map('n', '<Space>', '<NOP>', opts('Disable space'))

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- better paste
map('n', '<C-S-v>', '"+gP', opts('Paste from system clipboard'))
map('n', '<C-S-c>', '"+y', opts('Copy to system clipboard'))
map('v', '<C-S-v>', '"+gP', opts('Paste from system clipboard'))
map('v', 'p', '"_dP', opts('Paste over currently selected text without yanking it'))
map('v', '<C-S-c>', '"+y', opts('Copy to system clipboard'))

-- toggles
map('n', '<leader>ut', function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, opts('Toggle light/dark mode'))
map('n', '<leader>ud', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, opts('Toggle light/dark mode'))
local toggles = {
  { 'spell',          's', 'spell check' },
  { 'relativenumber', 'n', 'relative line numbers' },
  { 'wrap',           'w', 'wrap' },
  { 'linebreak',      'b', 'linebreak' },
}
for _, toggle in ipairs(toggles) do
  map('n', '<leader>u' .. toggle[2], function()
    vim.o[toggle[1]] = not vim.o[toggle[1]]
  end, opts('Toggle ' .. toggle[3]))
end

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

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Command shortcuts
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save' })

map('n', '<leader>\\', function()
  vim.cmd('nohlsearch')
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(k, v)
    return vim.api.nvim_win_get_config(v).relative ~= ''
        and v ~= vim.api.nvim_get_current_win()
  end)
  for _, w in ipairs(inactive_floating_wins) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end, { desc = 'Clear screen' })
