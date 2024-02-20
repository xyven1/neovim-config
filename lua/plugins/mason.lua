return {
  {
    'williamboman/mason.nvim',
    cmd = { "Mason" },
    opts = {
      PATH = 'append',
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {},
      inlay_hints = { enabled = true }
    },
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    event = "BufEnter",
    opts = {
      automatic_setup = true,
    },
  },
}
