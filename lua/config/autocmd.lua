-- Remove all trailing whitespace on save
local trim = vim.api.nvim_create_augroup('TrimWhiteSpace', { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = trim,
  callback = function()
    local view = vim.fn.winsaveview()
    if view then
      vim.api.nvim_command [[%s/\s\+$//e]]
      vim.fn.winrestview(view)
    end
  end
})
-- autocmd TerminalOpen * setlocal nonumber
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_option_value("number", false, { scope = "local" })
    vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
  end
})
