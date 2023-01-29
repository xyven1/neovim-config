local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

map("n", ";", ":", opts)
map("v", ";", ":", opts)

-- Tab switch buffer
map("n", "<TAB>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opts)
map("n", "[b", ":BufferLineMovePrev<CR>", opts)
map("n", "]b", ":BufferLineMoveNext<CR>", opts)

-- map the leader key
map("n", "<Space>", "<NOP>", opts)
vim.g.mapleader = " "

local fzf = require("fzf-lua")
map("n", "<Leader>c", fzf.commands, opts)
map("n", "<Leader>o", fzf.files, opts)
map("n", "<Leader>g", fzf.builtin, opts)

-- map keys for debuggingk
local dap = require("dap")
map("n", "<F5>", dap.continue, opts)
map("n", "<F10>", dap.step_over, opts)
map("n", "<F11>", dap.step_into, opts)
map("n", "<F12>", dap.step_out, opts)
map("n", "<Leader>b", dap.toggle_breakpoint, opts)
map("n", "<Leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)

-- coq mappings
map('i', '<esc>', function() return vim.fn.pumvisible() == 1 and "<c-e><esc>" or "<esc>" end, expr_opts)
map('i', '<c-c', function() return vim.fn.pumvisible() == 1 and "<c-e><c-c>" or "<c-c>" end, expr_opts)
map('i', '<tab>', function() return vim.fn.pumvisible() == 1 and "<c-n>" or "<tab>" end, expr_opts)
map('i', '<s-tab>', function() return vim.fn.pumvisible() == 1 and "<c-p>" or "<bs>" end, expr_opts)

-- auto pairs
local npairs = require('nvim-autopairs')
map('i', '<cr>', function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end, expr_opts)

map('i', '<bs>', function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. '<bs>'
  else
    return '<bs>'
  end
end, expr_opts)

-- paste over currently selected text without yanking it
map("v", "p", "\"_dP", opts)

-- Resizing panes
map("n", "<Left>", ":vertical resize +5<CR>", opts)
map("n", "<Right>", ":vertical resize -5<CR>", opts)
map("n", "<Up>", ":resize -1<CR>", opts)
map("n", "<Down>", ":resize +1<CR>", opts)

-- Opening File Explorer
map("n", "<Leader>t", ":NvimTreeToggle<CR>", opts)

-- Close Buffers
local close = require("close_buffers")
map("n", "<Leader>xx", function() close.delete({ type = "this" }) end, opts)
map("n", "<Leader>xf", function() close.delete({ type = "this", force = true }) end, opts)
map("n", "<Leader>xn", function() close.delete({ type = "nameless" }) end, opts)
map("n", "<Leader>xh", function() close.delete({ type = "hidden" }) end, opts)
map("n", "<Leader>xa", function() close.delete({ type = "all" }) end, opts)
map("n", "<Leader>xo", function() close.delete({ type = "other" }) end, opts)

function EscapePair()
  local closers = { ")", "]", "}", ">", "'", "\"", "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

map("i", "<C-l>", EscapePair, opts)
