-- Remove all trailing whitespace on save
vim.api.nvim_exec([[
  augroup TrimWhiteSpace
    au!
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
  augroup END
  ]], false)
-- Set color scheme
vim.cmd([[
  colorscheme vscode
]])

