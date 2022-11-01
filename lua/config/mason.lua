require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {}
})
require('mason-nvim-dap').setup({
  automatic_setup = true,
})
