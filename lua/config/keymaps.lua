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

-- Option Toggles
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>un")
Snacks.toggle.option("linebreak", { name = "Line Break" }):map("<leader>ub")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ut")
Snacks.toggle.option("conceallevel",
  { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uC")
Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
    :map("<leader>uA")

-- Diagnostic Toggles
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.new({
  id = "diagnostics_lines",
  name = "Diagnostics Lines",
  get = function() return not not vim.diagnostic.config().virtual_lines end,
  set = function(state)
    vim.diagnostic.config({ virtual_lines = state })
  end,
}):map("<leader>ul")
Snacks.toggle.inlay_hints():map('<leader>uh')
Snacks.toggle.new({
  id = 'dap_virtual_text',
  name = 'Dap Virtual Text',
  get = function()
    return require('nvim-dap-virtual-text').is_enabled()
  end,
  set = function(state)
    local d = require('nvim-dap-virtual-text')
    if state then d.disable() else d.enable() end
  end,
}):map('<leader>uv')

-- UI Toggles
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.new({
  id = 'colorizer',
  name = 'Colorizer',
  get = function() return require('colorizer').is_buffer_attached(0) end,
  set = function(state)
    local c = require('colorizer')
    if state then c.detach_from_buffer(0) else c.attach_to_buffer(0) end
  end
})
Snacks.toggle.new({
  id = 'illuminate',
  name = 'Hover Illumination',
  get = function() return not require('illuminate').is_paused() end,
  set = function(state)
    local i = require('illuminate')
    if state then i.pause() else i.resume() end
  end,
}):map('<leader>ui')
local markdownMode = false;
Snacks.toggle.new({
  id = 'markdown',
  name = 'Markdown Mode',
  get = function() return markdownMode end,
  set = function(state)
    local rm = require('render-markdown')
    if state then rm.enable() else rm.disable() end
  end,
}):map('<leader>um')

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

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Command shortcuts
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
map('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save' })

map('n', '<leader>\\', function()
  vim.cmd('nohlsearch')
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
    return vim.api.nvim_win_get_config(v).relative ~= ''
        and v ~= vim.api.nvim_get_current_win()
  end)
  for _, w in ipairs(inactive_floating_wins) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end, { desc = 'Clear screen' })
