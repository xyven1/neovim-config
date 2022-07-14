-- Remove all trailing whitespace on save
vim.api.nvim_exec([[
  augroup TrimWhiteSpace
    au!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
  autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()
  ]], false)
-- Set color scheme
vim.cmd([[
  colorscheme vscode
]])

