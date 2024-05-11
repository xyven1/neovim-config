return {
  {
    'williamboman/mason.nvim',
    event = "VeryLazy",
    config = function(opts)
      local distro = vim.fn.system('cat /etc/os-release | grep "^ID=" | cut -d "=" -f 2 | tr -d "\n"')
      if distro == "nixos" then
        opts.PATH = "skip"
      end
      require('mason').setup(opts)
    end,
    opts = {}
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
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
    opts = {},
    config = function(_, opts)
      local mdap = require('mason-nvim-dap')
      mdap.setup(vim.tbl_deep_extend("force", opts, {
        handlers = { mdap.default_setup }
      }))
    end,
  },
}
