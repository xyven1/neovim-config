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
