return {
  {
    'williamboman/mason.nvim',
    event = "VeryLazy",
    config = function(opts)
      local distro = vim.fn.system('cat /etc/os-release | grep "^ID=" | cut -d "=" -f 2 | tr -d "\n"')
      opts.PATH = distro == "nixos" and "skip" or "append"
      require('mason').setup(opts)
    end,
    opts = {}
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
    event = "VeryLazy",
    dependencies = { 'williamboman/mason.nvim' },
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      table.insert(opts.handlers, 0, require('mason-nvim-dap').default_setup)
      return opts
    end,
  },
}
