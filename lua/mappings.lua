local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map("n", ";", ":", default_options)
map("v", ";", ":", default_options)

-- Tab switch buffer
map("n", "<TAB>", ":bnext<CR>", default_options)
map("n", "<S-TAB>", ":bprevious<CR>", default_options)

-- map the leader key
map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "

map("n", "<Leader>c", ":lua require('fzf-lua').commands()<CR>", default_options)
map("n", "<Leader>o", ":lua require('fzf-lua').files()<CR>", default_options)

-- map keys for debuggingk
map("n", "<F5>", ":lua require('dapui').toggle()<CR>", default_options)
map("n", "<F5>", ":lua require'dap'.continue()<CR>", default_options)
map("n", "<F10>", ":lua require'dap'.step_over()<CR>", default_options)
map("n", "<F11>", ":lua require'dap'.step_into()<CR>", default_options)
map("n", "<F12>", ":lua require'dap'.step_out()<CR>", default_options)
map("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", default_options)
map("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", default_options)


-- paste over currently selected text without yanking it
map("v", "p", "\"_dP", default_options)

-- Resizing panes
map("n", "<Left>", ":vertical resize +5<CR>", default_options)
map("n", "<Right>", ":vertical resize -5<CR>", default_options)
map("n", "<Up>", ":resize -1<CR>", default_options)
map("n", "<Down>", ":resize +1<CR>", default_options)

function EscapePair()
    local closers = {")", "]", "}", ">", "'", "\"", "`", ","}
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
        vim.api.nvim_win_set_cursor(0, {row, col + closer_col})
    else
        vim.api.nvim_win_set_cursor(0, {row, col + 1})
    end
end

map("i", "<C-l>", "<cmd>lua EscapePair()<CR>", default_options)
