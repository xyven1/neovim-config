require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {}
})
require("dap").setup()
require("mason-nvim-dap").setup({
  ensure_installed = {}
})
